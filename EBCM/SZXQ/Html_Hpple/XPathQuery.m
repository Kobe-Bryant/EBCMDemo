//
//  XPathQuery.m
//  FuelFinder
//
//  Created by Matt Gallagher on 4/08/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "XPathQuery.h"

#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>

NSDictionary *DictionaryForNode(xmlNodePtr currentNode, NSMutableDictionary *parentResult);
NSArray *PerformXPathQuery(xmlDocPtr doc, NSString *query);

NSDictionary *DictionaryForNode(xmlNodePtr currentNode, NSMutableDictionary *parentResult)
{
  NSMutableDictionary *resultForNode = [NSMutableDictionary dictionary];

  if (currentNode->name)
    {
      NSString *currentNodeContent =
        [NSString stringWithCString:(const char *)currentNode->name encoding:NSUTF8StringEncoding];
      [resultForNode setObject:currentNodeContent forKey:@"nodeName"];
    }

  if (currentNode->content && currentNode->content != (xmlChar *)-1)
    {
      NSString *currentNodeContent =
        [NSString stringWithCString:(const char *)currentNode->content encoding:NSUTF8StringEncoding];

      if ([[resultForNode objectForKey:@"nodeName"] isEqual:@"text"] && parentResult)
        {
          [parentResult
            setObject:
              [currentNodeContent
                stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
            forKey:@"nodeContent"];
          return nil;
        }

      [resultForNode setObject:currentNodeContent forKey:@"nodeContent"];
    }

//    获取节点目录
  xmlAttr *attribute = currentNode->properties;
  if (attribute)
    {
      NSMutableArray *attributeArray = [NSMutableArray array];
      while (attribute)
        {
          NSMutableDictionary *attributeDictionary = [NSMutableDictionary dictionary];
//            获取节点目录名字 字符串
          NSString *attributeName =
            [NSString stringWithCString:(const char *)attribute->name encoding:NSUTF8StringEncoding];
          if (attributeName)
            {
//              获取节点目录名字到  attributeDictionary
              [attributeDictionary setObject:attributeName forKey:@"attributeName"];
            }
//        如果节点目录下还有子节点则继续从头开始获取内容
          if (attribute->children)
            {
              NSDictionary *childDictionary = DictionaryForNode(attribute->children, attributeDictionary);
              if (childDictionary)
                {
                  [attributeDictionary setObject:childDictionary forKey:@"attributeContent"];
                }
            }
//          把获取节点名字的字典给 可变数组
          if ([attributeDictionary count] > 0)
            {
              [attributeArray addObject:attributeDictionary];
            }
//            继续目录中下一个节点
          attribute = attribute->next;
        }

      if ([attributeArray count] > 0)
        {
//          把mutablearry 给 可变字典；（目录名字）  
          [resultForNode setObject:attributeArray forKey:@"nodeAttributeArray"];
        }
    }

//    获取子节点指针
  xmlNodePtr childNode = currentNode->children;
  if (childNode)
    {
      NSMutableArray *childContentArray = [NSMutableArray array];
      while (childNode)
        {
          NSDictionary *childDictionary = DictionaryForNode(childNode, resultForNode);
          if (childDictionary)
            {
              [childContentArray addObject:childDictionary];
            }
          childNode = childNode->next;
        }
      if ([childContentArray count] > 0)
        {
          [resultForNode setObject:childContentArray forKey:@"nodeChildArray"];
        }
    }

  return resultForNode;
}

NSArray *PerformXPathQuery(xmlDocPtr doc, NSString *query)
{
  xmlXPathContextPtr xpathCtx;
  xmlXPathObjectPtr xpathObj;

  /* Create xpath evaluation context */
//    创建新的环境 放doc数据流的内容
  xpathCtx = xmlXPathNewContext(doc);
  if(xpathCtx == NULL)
    {
      NSLog(@"Unable to create XPath context.");
      return nil;
    }

  /* Evaluate xpath expression */
  xpathObj = xmlXPathEvalExpression((xmlChar *)[query cStringUsingEncoding:NSUTF8StringEncoding], xpathCtx);
  if(xpathObj == NULL) {
    NSLog(@"Unable to evaluate XPath.");
    xmlXPathFreeContext(xpathCtx);
    return nil;
  }

  xmlNodeSetPtr nodes = xpathObj->nodesetval;
  if (!nodes)
    {
      NSLog(@"Nodes was nil.");
      xmlXPathFreeObject(xpathObj);
      xmlXPathFreeContext(xpathCtx);
      return nil;
    }

  NSMutableArray *resultNodes = [NSMutableArray array];
  for (NSInteger i = 0; i < nodes->nodeNr; i++)
    {
//        获取节点名字 和内容
      NSDictionary *nodeDictionary = DictionaryForNode(nodes->nodeTab[i], nil);
      if (nodeDictionary)
        {
          [resultNodes addObject:nodeDictionary];
        }
    }

  /* Cleanup */
  xmlXPathFreeObject(xpathObj);
  xmlXPathFreeContext(xpathCtx);

  return resultNodes;
}

NSArray *PerformHTMLXPathQuery(NSData *document, NSString *query)
{
//    像数据库一样  加载库 后这里是创建文档；
  xmlDocPtr doc;
//  htmlReadMemory（memory 记忆  内存）  html中读取里面数据
//   htmlReadMemory(const char *buffer,int size,const char *URL,const char *encoding,int options);
//      buffer:	a pointer to a char array
//      size:	the size of the array
//      URL:	the base URL to use for the document
//      encoding:	the document encoding, or NULL
//      options:	a combination of htmlParserOption(s) 结合了 html选择程序解析
//      Returns:	the resulting document tree
  /* Load XML document */
//    [document bytes] 这是这数据流离的consts（常量）字节数  直接把指针指向的数组放过来了 所以没另外创建指针
  doc = htmlReadMemory([document bytes], (int)[document length], "", NULL, HTML_PARSE_NOWARNING | HTML_PARSE_NOERROR);

  if (doc == NULL)
    {
      NSLog(@"Unable to parse.");
      return nil;
    }

  NSArray *result = PerformXPathQuery(doc, query);
  xmlFreeDoc(doc);

  return result;
}

NSArray *PerformXMLXPathQuery(NSData *document, NSString *query)
{
  xmlDocPtr doc;

  /* Load XML document */
  doc = xmlReadMemory([document bytes], (int)[document length], "", NULL, XML_PARSE_RECOVER);

  if (doc == NULL)
    {
      NSLog(@"Unable to parse.");
      return nil;
    }

  NSArray *result = PerformXPathQuery(doc, query);
  xmlFreeDoc(doc);

  return result;
}
