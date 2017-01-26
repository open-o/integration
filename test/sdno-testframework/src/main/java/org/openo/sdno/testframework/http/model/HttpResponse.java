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

import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Model class of HttpResponse.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 25, 2016
 */
public class HttpResponse {

    private int status;

    private Map<String, String> headers;

    @JsonIgnore
    private String data;

    /**
     * user do not use this field
     */
    private Object json;

    /**
     * @return Returns the status.
     */
    public int getStatus() {
        return status;
    }

    /**
     * @param status The status to set.
     */
    public void setStatus(int status) {
        this.status = status;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    /**
     * @return Returns the headers.
     */
    public Map<String, String> getHeaders() {
        return headers;
    }

    /**
     * @param headers The headers to set.
     */
    public void setHeaders(Map<String, String> headers) {
        this.headers = headers;
    }

    /**
     * @return Returns the json.
     */
    public Object getJson() {
        return json;
    }

    /**
     * @param json The json to set.
     */
    public void setJson(Object json) {
        this.json = json;
    }

    /**
     * Copy data from other object.<br>
     * 
     * @param otherObject other HttpResponse object
     * @since SDNO 0.5
     */
    public void copyBasicData(HttpResponse otherObject) {
        if(null != otherObject) {
            this.setStatus(otherObject.getStatus());
            this.setHeaders(otherObject.getHeaders());
            this.setData(otherObject.getData());
        }
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((data == null) ? 0 : data.hashCode());
        result = prime * result + ((headers == null) ? 0 : headers.hashCode());
        result = prime * result + ((json == null) ? 0 : json.hashCode());
        result = prime * result + status;
        return result;
    }

    @Override
    public boolean equals(Object obj) {

        if(!(obj instanceof HttpResponse)) {
            return false;
        }

        if(this == obj) {
            return true;
        }

        HttpResponse otherObject = (HttpResponse)obj;

        boolean statusJudge = this.status == otherObject.status;

        boolean headerJudge = true;
        if((null != this.headers) && !this.headers.isEmpty()) {
            for(Map.Entry<String, String> curEntity : this.headers.entrySet()) {
                if(!this.containsMapEntity(otherObject.headers, curEntity)) {
                    headerJudge = false;
                    break;
                }
            }
        }

        boolean bodyjudge = (null == this.data && null == otherObject.data)
                || (null != this.data && this.data.equals(otherObject.data));

        return statusJudge && headerJudge && bodyjudge;
    }

    @Override
    public String toString() {
        return "[" + "status:" + status + " body:" + data + "]";
    }

    private boolean containsMapEntity(Map<String, String> headerMap, Map.Entry<String, String> entity) {
        if(null == headerMap) {
            return false;
        }

        String value = headerMap.get(entity.getKey());
        if(entity.getValue().equals(value)) {
            return true;
        }

        return false;
    }

}
