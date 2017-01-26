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

package org.openo.sdno.testframework.http.model;

/**
 * Model class of HttpRequest and HttpResponse.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 25, 2016
 */
public class HttpRquestResponse {

    private HttpRequest request;

    private HttpResponse response;

    /**
     * Constructor<br>
     * 
     * @since SDNO 0.5
     */
    public HttpRquestResponse() {
        // empty construction
    }

    /**
     * Constructor<br>
     * 
     * @param request Http request to set
     * @param response Http response to set
     * @since SDNO 0.5
     */
    public HttpRquestResponse(HttpRequest request, HttpResponse response) {
        this.request = request;
        this.response = response;
    }

    /**
     * @return Returns the request.
     */
    public HttpRequest getRequest() {
        return request;
    }

    /**
     * @param request The request to set.
     */
    public void setRequest(HttpRequest request) {
        this.request = request;
    }

    /**
     * @return Returns the response.
     */
    public HttpResponse getResponse() {
        return response;
    }

    /**
     * @param response The response to set.
     */
    public void setResponse(HttpResponse response) {
        this.response = response;
    }

    @Override
    public String toString() {
        return "[" + "request:" + request + " response:" + response + "]";
    }
}
