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

package org.openo.sdno.testframework.config;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.codehaus.jackson.type.TypeReference;
import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.sdno.framework.container.util.JsonUtil;
import org.openo.sdno.testframework.util.file.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Class of Url Configuration.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 15, 2016
 */
public class UrlConfiguration {

    private static final Logger LOGGER = LoggerFactory.getLogger(UrlConfiguration.class);

    private static final String SERVER_CONFIG = "src/integration-test/resources/urlconfig.json";

    private static final String URL_KEY = "url";

    private static final String PREFIX_KEY = "prefix";

    private List<Map<String, String>> paramMapList = null;

    /**
     * Constructor.<br>
     * 
     * @since SDNO 0.5
     */
    public UrlConfiguration() {
        loadProperties();
    }

    /**
     * Add prefix to url.<br>
     * 
     * @param url The url to add prefix
     * @return The added prefix url
     * @since SDNO 0.5
     */
    public String processUrlPrefix(String url) {
        String newUrl = url;
        if(null == paramMapList) {
            return newUrl;
        }

        for(Map<String, String> urlMap : paramMapList) {
            if(url.contains(urlMap.get(URL_KEY))) {
                newUrl = urlMap.get(PREFIX_KEY) + url;
                break;
            }
        }

        return newUrl;
    }

    private void loadProperties() {
        try {
            String urlJsonConent = FileUtils.readFromJson(new File(SERVER_CONFIG));
            paramMapList = JsonUtil.fromJson(urlJsonConent, new TypeReference<List<Map<String, String>>>() {});
        } catch(ServiceException e) {
            LOGGER.error("Load Url Json File failed!", e);
            return;
        }
    }
}
