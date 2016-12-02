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

package org.openo.sdno.testframework.restclient;

import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.baseservice.roa.util.restclient.RestfulFactory;
import org.openo.baseservice.roa.util.restclient.RestfulOptions;
import org.openo.baseservice.roa.util.restclient.RestfulParametes;
import org.openo.baseservice.roa.util.restclient.RestfulResponse;
import org.openo.sdno.testframework.config.ServerConfiguration;

/**
 * Class of Http Rest Client.<br>
 * 
 * @author
 * @version SDNO 0.5 2016-07-31
 */
public class HttpRestClient {

    private ServerConfiguration serverConfig = new ServerConfiguration();

    /**
     * Call the post method of restful.<br>
     * 
     * @param url The url of the interface to be called
     * @param restParams The restful parameters
     * @return The response of the restful
     * @since SDNO 0.5
     */
    public RestfulResponse post(String url, RestfulParametes restParams) throws ServiceException {
        return RestfulFactory.getRestInstance(RestfulFactory.PROTO_HTTP).post(url, restParams, getRestfulOptions());
    }

    /**
     * Call the delete method of restful.<br>
     * 
     * @param url The url of the interface to be called
     * @param restParams The restful parameters
     * @return The response of the restful
     * @since SDNO 0.5
     */
    public RestfulResponse delete(String url, RestfulParametes restParams) throws ServiceException {
        return RestfulFactory.getRestInstance(RestfulFactory.PROTO_HTTP).delete(url, restParams, getRestfulOptions());
    }

    /**
     * Call the put method of restful.<br>
     * 
     * @param url The url of the interface to be called
     * @param restParams The restful parameters
     * @return The response of the restful
     * @since SDNO 0.5
     */
    public RestfulResponse put(String url, RestfulParametes restParams) throws ServiceException {
        return RestfulFactory.getRestInstance(RestfulFactory.PROTO_HTTP).put(url, restParams, getRestfulOptions());
    }

    /**
     * Call the get method of restful.<br>
     * 
     * @param url The url of the interface to be called
     * @param restParams The restful parameters
     * @return The response of the restful
     * @since SDNO 0.5
     */
    public RestfulResponse get(String url, RestfulParametes restParams) throws ServiceException {
        return RestfulFactory.getRestInstance(RestfulFactory.PROTO_HTTP).get(url, restParams, getRestfulOptions());
    }

    /**
     * Call the head method of restful.<br>
     * 
     * @param url The url of the interface to be called
     * @param restParams The restful parameters
     * @return The response of the restful
     * @since SDNO 0.5
     */
    public RestfulResponse head(String url, RestfulParametes restParams) throws ServiceException {
        return RestfulFactory.getRestInstance(RestfulFactory.PROTO_HTTP).head(url, restParams, getRestfulOptions());
    }

    /**
     * Call the patch method of restful.<br>
     * 
     * @param url The url of the interface to be called
     * @param restParams The restful parameters
     * @return The response of the restful
     * @since SDNO 0.5
     */
    public RestfulResponse patch(String url, RestfulParametes restParams) throws ServiceException {
        return RestfulFactory.getRestInstance(RestfulFactory.PROTO_HTTP).patch(url, restParams, getRestfulOptions());
    }

    private RestfulOptions getRestfulOptions() throws ServiceException {
        RestfulOptions restfulOptions = new RestfulOptions();
        restfulOptions.setHost(serverConfig.getServerIpAddress());
        restfulOptions.setPort(serverConfig.getServerPort());
        restfulOptions.setRestTimeout(serverConfig.getRestTimeout());
        return restfulOptions;
    }

}
