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

public class HttpConstants {

    public static final int ERR_FAILED = 500;

    public static final int RESPOND_OK = 200;

    public static final int NOT_FOUND = 404;

    public static final int BAD_REQUEST = 400;

    public static final int EXCEED_REQUEST = 413;

    /**
     * Constructor.<br>
     * 
     * @since SDNO 0.5
     */
    private HttpConstants() {

    }

    /**
     * HTTP 2xx (success) indicates a successfully processed request status code. 200 (success)
     * server has successfully processed the request. Typically, this means that the server provided
     * the requested page.<br>
     * 
     * @param httpCode error code return from http request
     * @return success if the http response code is 2xx
     * @since SDNO 0.5
     */
    public static boolean isSucess(int httpCode) {
        return httpCode / 100 == 2;
    }

}
