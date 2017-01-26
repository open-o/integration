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

import java.io.File;

import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.baseservice.roa.util.restclient.RestfulResponse;
import org.openo.sdno.testframework.util.file.FileUtils;
import org.openo.sdno.testframework.util.file.JsonUtil;

/**
 * Class of Moco Model Operation.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 25, 2016
 */
public class HttpModelUtils {

    private HttpModelUtils() {
        // empty construction
    }

    /**
     * Read Request and Response Object from file.<br>
     * 
     * @param jsonFile JSON file
     * @return Request and Response Object
     * @since SDNO 0.5
     */
    public static HttpRquestResponse praseHttpRquestResponseFromFile(String jsonFile) throws ServiceException {
        String content = FileUtils.readFromJson(new File(jsonFile));
        return praseHttpRquestResponse(content);
    }

    /**
     * Read Request and Response Object from json content.<br>
     * 
     * @param jsonContent JSON content
     * @return Request and Response Object
     * @since SDNO 0.5
     */
    public static HttpRquestResponse praseHttpRquestResponse(String jsonContent) {
        HttpRquestResponse httpObject = JsonUtil.fromJson(jsonContent, HttpRquestResponse.class);
        // convert data to Object
        httpObject.getRequest().setData(JsonUtil.toJson(httpObject.getRequest().getJson()));
        httpObject.getResponse().setData(JsonUtil.toJson(httpObject.getResponse().getJson()));
        return httpObject;
    }

    /**
     * Convert response.<br>
     * 
     * @param restfulResponse The restful response
     * @return The converted response
     * @since SDNO 0.5
     */
    public static HttpResponse convertResponse(RestfulResponse restfulResponse) {
        HttpResponse response = new HttpResponse();
        response.setStatus(restfulResponse.getStatus());
        response.setHeaders(restfulResponse.getRespHeaderMap());
        response.setData(restfulResponse.getResponseContent());
        return response;
    }
}
