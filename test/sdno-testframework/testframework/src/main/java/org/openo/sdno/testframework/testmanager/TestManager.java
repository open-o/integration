/*
 * Copyright 2016 Huawei Technologies Co., Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.openo.sdno.testframework.testmanager;

import static org.junit.Assert.assertEquals;

import java.io.File;
import java.util.Map;

import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.baseservice.roa.util.restclient.RestfulParametes;
import org.openo.baseservice.roa.util.restclient.RestfulResponse;
import org.openo.sdno.testframework.checker.DefaultChecker;
import org.openo.sdno.testframework.checker.IChecker;
import org.openo.sdno.testframework.http.model.HttpModelUtils;
import org.openo.sdno.testframework.http.model.HttpRequest;
import org.openo.sdno.testframework.http.model.HttpResponse;
import org.openo.sdno.testframework.http.model.HttpRquestResponse;
import org.openo.sdno.testframework.restclient.HttpRestClient;
import org.openo.sdno.testframework.util.file.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * The test manager,and when we do a test case,we need to extend this class.<br>
 * 
 * @author
 * @version SDNO 0.5 Aug 15, 2016
 */
public class TestManager {

    private static final Logger LOGGER = LoggerFactory.getLogger(TestManager.class);

    private HttpRestClient restClient = new HttpRestClient();

    /**
     * Constructor<br>
     * 
     * @since SDNO 0.5
     */
    public TestManager() {
        // a empty constructor to construct a empty object
    }

    /**
     * Realized test case.<br>
     * 
     * @param file The test case file
     * @param checker The checker
     * @return The restful response
     * @since SDNO 0.5
     */
    public HttpResponse execTestCase(File file, IChecker checker) throws ServiceException {
        String content = FileUtils.readFromJson(file);
        HttpRquestResponse httpObject = HttpModelUtils.praseHttpRquestResponse(content);
        return send(httpObject.getRequest(), checker);
    }

    /**
     * Realized test case.<br>
     * 
     * @param file The test case file
     * @return The restful response
     * @since SDNO 0.5
     */
    public HttpResponse execTestCase(File file) throws ServiceException {
        String content = FileUtils.readFromJson(file);
        HttpRquestResponse httpObject = HttpModelUtils.praseHttpRquestResponse(content);
        return send(httpObject.getRequest(), httpObject.getResponse());
    }

    /**
     * Realized test case.<br>
     * 
     * @param request The http request
     * @param checker The checker
     * @return The restful response
     * @since SDNO 0.5
     */
    public HttpResponse execTestCase(HttpRequest request, IChecker checker) throws ServiceException {
        return send(request, checker);
    }

    /**
     * Realized test case.<br>
     * 
     * @param request The http request
     * @param response The excepted response
     * @return The restful response
     * @since SDNO 0.5
     */
    public HttpResponse execTestCase(HttpRequest request, HttpResponse response) throws ServiceException {
        return send(request, response);
    }

    /**
     * Do the send and check the response.<br>
     * 
     * @param request The http request
     * @param checker The checker
     * @return The converted response
     * @since SDNO 0.5
     */
    public HttpResponse send(HttpRequest request, IChecker checker) throws ServiceException {
        RestfulResponse responseResult = doSend(request);
        HttpResponse response = HttpModelUtils.convertResponse(responseResult);
        assertEquals(checker.check(response), true);
        return response;
    }

    private HttpResponse send(HttpRequest request, HttpResponse response) throws ServiceException {
        RestfulResponse responseResult = doSend(request);
        DefaultChecker checker = new DefaultChecker(response);
        HttpResponse httpResponse = HttpModelUtils.convertResponse(responseResult);
        assertEquals(checker.check(httpResponse), true);
        return httpResponse;
    }

    private RestfulResponse doSend(HttpRequest request) throws ServiceException {
        String url = request.getUri();
        String method = request.getMethod();
        String body = request.getData();

        final RestfulParametes restfulParametes = new RestfulParametes();

        Map<String, String> requestHeaders = request.getHeaders();
        if(null != requestHeaders) {
            for(Map.Entry<String, String> curEntity : requestHeaders.entrySet()) {
                restfulParametes.putHttpContextHeader(curEntity.getKey(), curEntity.getValue());
            }
        }

        Map<String, String> paramMap = request.getQueries();
        if(null != paramMap) {
            restfulParametes.setParamMap(paramMap);
        }

        if(null != body) {
            restfulParametes.setRawData(body);
        }

        return callRestfulMotheds(url, method, restfulParametes);
    }

    private RestfulResponse callRestfulMotheds(String url, String method, final RestfulParametes restfulParametes)
            throws ServiceException {
        switch(method) {
            case "post": {
                return restClient.post(url, restfulParametes);
            }
            case "get": {
                return restClient.get(url, restfulParametes);
            }
            case "put": {
                return restClient.put(url, restfulParametes);
            }
            case "delete": {
                return restClient.delete(url, restfulParametes);
            }
            case "head": {
                return restClient.head(url, restfulParametes);
            }
            case "patch": {
                return restClient.patch(url, restfulParametes);
            }
            default: {
                LOGGER.error("The method is unsupported.");
                throw new ServiceException("The method is unsupported.");
            }
        }
    }
}
