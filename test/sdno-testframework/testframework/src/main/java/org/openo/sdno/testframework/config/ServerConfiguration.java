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

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Class of TestManager Configuration.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 15, 2016
 */
public class ServerConfiguration {

    private static final Logger LOGGER = LoggerFactory.getLogger(ServerConfiguration.class);

    private static final String DEFAULT_MOCO_HTTP_PORT = "12306";

    private static final String DEFAULT_MOCO_HTTPS_PORT = "12307";

    private static final String DEFAULT_REST_TIMEOUT = "30000";

    private static final String DEFAULT_SERVER_PORT = "8080";

    private static final String SERVER_CONFIG = "src/integration-test/resources/server.properties";

    private Properties properties = new Properties();

    /**
     * Constructor<br>
     * 
     * @since SDNO 0.5
     */
    public ServerConfiguration() {
        loadProperties();
    }

    /**
     * Get Server Port.<br>
     * 
     * @return Server Port
     * @since SDNO 0.5
     */
    public int getServerPort() {
        String portStr = properties.getProperty("serverport", DEFAULT_SERVER_PORT);
        try {
            return Integer.parseInt(portStr);
        } catch(NumberFormatException e) {
            LOGGER.error("Port prase failed!");
            return Integer.parseInt(DEFAULT_SERVER_PORT);
        }
    }

    /**
     * Get Server IpAddress.<br>
     * 
     * @return Server IpAddress
     * @since SDNO 0.5
     */
    public String getServerIpAddress() {
        return properties.getProperty("serverip", "localhost");
    }

    /**
     * Get Moco Http Port.<br>
     * 
     * @return Http Server Port
     * @since SDNO 0.5
     */
    public int getMocoHttpPort() {
        String portStr = properties.getProperty("mocohttpport", DEFAULT_MOCO_HTTP_PORT);
        try {
            return Integer.parseInt(portStr);
        } catch(NumberFormatException e) {
            LOGGER.error("Moco Http Server Port prase failed!");
            return Integer.parseInt(DEFAULT_MOCO_HTTP_PORT);
        }
    }

    /**
     * Get Moco Https Port.<br>
     * 
     * @return Https Server Port
     * @since SDNO 0.5
     */
    public int getMocoHttpsPort() {
        String portStr = properties.getProperty("mocohttpsport", DEFAULT_MOCO_HTTPS_PORT);
        try {
            return Integer.parseInt(portStr);
        } catch(NumberFormatException e) {
            LOGGER.error("Moco Https Server Port prase failed!", e);
            return Integer.parseInt(DEFAULT_MOCO_HTTPS_PORT);
        }
    }

    /**
     * Get Rest Timeout.<br>
     * 
     * @return Rest Timeout
     * @since SDNO 0.5
     */
    public int getRestTimeout() {

        String timeOutStr = properties.getProperty("timeout", DEFAULT_REST_TIMEOUT);
        try {
            return Integer.parseInt(timeOutStr);
        } catch(NumberFormatException e) {
            LOGGER.error("Https Rest timeOut prase failed!", e);
            return Integer.parseInt(DEFAULT_REST_TIMEOUT);
        }

    }

    private void loadProperties() {
        try {
            FileInputStream fin = new FileInputStream(SERVER_CONFIG);
            properties.load(fin);
        } catch(IOException e) {
            LOGGER.error("Load Property File failed!", e);
        }
    }
}
