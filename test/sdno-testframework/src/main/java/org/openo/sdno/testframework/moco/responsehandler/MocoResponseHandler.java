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

package org.openo.sdno.testframework.moco.responsehandler;

import java.util.HashMap;
import java.util.Map;

import org.openo.sdno.testframework.http.model.HttpRequest;
import org.openo.sdno.testframework.http.model.HttpResponse;
import org.openo.sdno.testframework.http.model.HttpRquestResponse;

import com.github.dreamhead.moco.MocoConfig;
import com.github.dreamhead.moco.ResponseHandler;
import com.github.dreamhead.moco.internal.SessionContext;
import com.github.dreamhead.moco.model.DefaultHttpRequest;
import com.github.dreamhead.moco.model.DefaultMutableHttpResponse;
import com.github.dreamhead.moco.model.MessageContent;
import com.google.common.collect.ImmutableMap;

/**
 * Base Class of Response Handler.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 25, 2016
 */
public class MocoResponseHandler implements ResponseHandler {

    private HttpResponse responseObject;

    /**
     * Constructor<br>
     * 
     * @since SDNO 0.5
     */
    public MocoResponseHandler() {
        // a empty constructor to construct a empty object.
    }

    /**
     * @param responseObject The responseObject to set.
     */
    public void setResponseObject(HttpResponse responseObject) {
        this.responseObject = responseObject;
    }

    @Override
    public ResponseHandler apply(MocoConfig config) {
        return null;
    }

    @Override
    public void writeToResponse(SessionContext context) {

        DefaultHttpRequest inHttpRequest = (DefaultHttpRequest)context.getRequest();
        DefaultMutableHttpResponse outHttpResponse = (DefaultMutableHttpResponse)context.getResponse();

        HttpRequest request = new HttpRequest();
        request.setUri(inHttpRequest.getUri());
        request.setMethod(inHttpRequest.getMethod().toString().toLowerCase());
        request.setHeaders(inHttpRequest.getHeaders());

        ImmutableMap<String, String[]> queryMap = inHttpRequest.getQueries();
        if(null != queryMap) {
            Map<String, String> newMap = new HashMap<String, String>();
            for(Map.Entry<String, String[]> curEntity : queryMap.entrySet()) {
                newMap.put(curEntity.getKey(), curEntity.getValue()[0]);
            }
            request.setQueries(newMap);
        }

        request.setData(inHttpRequest.getContent().toString());

        // create new response data
        HttpResponse response = new HttpResponse();
        response.copyBasicData(responseObject);

        HttpRquestResponse httpObject = new HttpRquestResponse(request, response);

        processRequestandResponse(httpObject);

        outHttpResponse.setStatus(response.getStatus());
        Map<String, String> headers = response.getHeaders();
        if(null != headers) {
            for(Map.Entry<String, String> entity : headers.entrySet()) {
                outHttpResponse.addHeader(entity.getKey(), entity.getValue());
            }
        }
        outHttpResponse.setContent(MessageContent.content(response.getData()));
    }

    /**
     * Process response of request.<br>
     * 
     * @param httpObject Moco Request and Response.
     * @since SDNO 0.5
     */
    protected void processRequestandResponse(HttpRquestResponse httpObject) {
        // a empty class need to override
    }

}
