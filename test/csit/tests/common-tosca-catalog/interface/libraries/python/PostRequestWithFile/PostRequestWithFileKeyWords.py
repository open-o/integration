#coding=utf-8
'''
Created on 2016年9月21日

@author: 6092002393
'''
import requests
from robot.api import logger

class PostRequestWithFileKeyWords(object):

    def PostRequestFile(self):  
        url = 'http://127.0.0.1:8200/openoapi/catalog/v1/csars'
        files = {'file': ('tseti.csar', open(r'E:\robotframework\demo\openo\libraries\rest\catalog\tseti.csar', 'rb'), 
                          'application/octet-stream', 
                          {'Content-Disposition':'form-data', 'name':'file','filename':'tseti.csar'})}
    
        logger.info('Post Request using : url=%s, files=%s'
            % (url, files))
        resp = requests.post(url, files=files)
        
        return resp
    
    def PostRequestFileUpload(self,url,uri,path,filename):
        finalurl = url+uri
        files = {'file': ('tseti.csar', open(path,'rb'), 
                          'application/octet-stream', 
                          {'Content-Disposition':'form-data', 'name':'file','filename':filename})}
    
        logger.info('Post Request using : finalurl =%s,path=%s,filename=%s,files=%s'
            % (finalurl,path,filename,files))
        resp = requests.post(finalurl, files=files)
        
        return resp