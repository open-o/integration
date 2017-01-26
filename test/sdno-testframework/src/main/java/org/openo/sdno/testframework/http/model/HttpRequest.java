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

import java.util.HashMap;
import java.util.Map;

import org.codehaus.jackson.annotate.JsonIgnore;

/**
 * Model class of HttpRequest.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 25, 2016
 */
public class HttpRequest {

    private String uri;

    private String method;

    private Map<String, String> headers;

    /**
     * user do not use this field
     */
    private Object json;

    private Map<String, String> queries;

    @JsonIgnore
    private String data;

    /**
     * @return Returns the uri.
     */
    public String getUri() {
        return uri;
    }

    /**
     * @param uri The uri to set.
     */
    public void setUri(String uri) {
        this.uri = uri;
    }

    /**
     * @return Returns the method.
     */
    public String getMethod() {
        return method;
    }

    /**
     * @param method The method to set.
     */
    public void setMethod(String method) {
        this.method = method;
    }

    /**
     * @param data The data to set.
     */
    public void setData(String data) {
        this.data = data;
    }

    /**
     * @return Returns the data.
     */
    public String getData() {
        return data;
    }

    /**
     * @param headers The headers to set.
     */
    public void setHeaders(Map<String, String> headers) {
        this.headers = headers;
    }

    /**
     * @return Returns the headers.
     */
    public Map<String, String> getHeaders() {
        return headers;
    }

    /**
     * @param json The json to set.
     */
    public void setJson(Object json) {
        this.json = json;
    }

    /**
     * @return Returns the json.
     */
    public Object getJson() {
        return json;
    }

    /**
     * @return Returns the queries.
     */
    public Map<String, String> getQueries() {
        return queries;
    }

    /**
     * @param queries The queries to set.
     */
    public void setQueries(Map<String, String> queries) {
        this.queries = queries;
    }

    /**
     * Add Request Header Parameters.<br>
     * 
     * @param key key
     * @param value value
     * @since SDNO 0.5
     */
    public void addRequestHeader(String key, String value) {
        if(null == headers) {
            headers = new HashMap<String, String>();
        }
        headers.put(key, value);
    }

    /**
     * Add Request Header Parameters.<br>
     * 
     * @param key key
     * @param value value
     * @since SDNO 0.5
     */
    public void addQueryParam(String key, String value) {
        if(null == queries) {
            queries = new HashMap<String, String>();
        }
        queries.put(key, value);
    }

    @Override
    public String toString() {
        return "[" + "uri:" + uri + " method:" + method + " body:" + data + "]";
    }
}
