/*
 * Copyright 2016-2017 Huawei Technologies Co., Ltd.
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

package org.openo.sdno.testframework.replace;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * The class to replace and get uuid in url.<br>
 * 
 * @author
 * @version SDNO 0.5 2016-7-4
 */
public class PathReplace {

    private static final Logger LOGGER = LoggerFactory.getLogger(PathReplace.class);

    private PathReplace() {
    }

    /**
     * Replace the uuid in url model with the real uuid.<br>
     * 
     * @param key The uuid name
     * @param urlModel The url model
     * @param uuid The real uuid to set
     * @return The real url with real uuid
     * @since SDNO 0.5
     */
    public static String replaceUuid(String key, String urlModel, String uuid) {
        String keyValue = "\\{" + key + "\\}";
        return urlModel.replaceAll(keyValue, uuid);
    }

    /**
     * Replace the key in url model with the value.<br>
     * ${KEY} ---> Value
     * 
     * @param key The key name
     * @param urlModel The string to be search and replace
     * @param value: key value
     * @return The string after replacing the ${key} with value
     * @since Integration 2.0
     */
    public static String replaceKey(String key, String urlModel, String value) {
        String keyValue = "\\$\\{" + key + "\\}";
        return urlModel.replaceAll(keyValue, value);
    }

    /**
     * Get the real uuid from real url.<br>
     * 
     * @param key The uuid name
     * @param urlModel The url model
     * @param url The real url
     * @return The real uuid
     * @since SDNO 0.5
     */
    public static String getUuidFromUrl(String key, String urlModel, String url) {

        String[] urlSplit = urlModel.split("/");
        String keyValue = "{" + key + "}";
        int index = -1;
        for(int i = 0; i < urlSplit.length; i++) {
            if(keyValue.equals(urlSplit[i])) {
                index = i;
                break;
            }
        }
        if(index == -1) {
            LOGGER.error("getUuidFromUrl: the key in url model is not exist.");
            return null;
        }

        String[] pathSplit = url.split("/");
        return pathSplit[index];
    }
}
