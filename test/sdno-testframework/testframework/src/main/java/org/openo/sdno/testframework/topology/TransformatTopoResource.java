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

package org.openo.sdno.testframework.topology;

import java.util.Map;

import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.sdno.testframework.util.file.FileUtils;

/**
 * Convert the input resource to standard json file through the template file.<br>
 * 
 * @author
 * @version SDNO 0.5 2016-6-20
 */
public class TransformatTopoResource {

    private static final String CONTROLLER_PATH = "src/main/resources/resourcejsonfile/controller.json";

    private static final String COMM_PARAM_PATH = "src/main/resources/resourcejsonfile/commparam.json";

    private static final String NETWORKELEMENT_PATH = "src/main/resources/resourcejsonfile/networkelement.json";

    private TransformatTopoResource() {

    }

    /**
     * Convert the controller resource to standard json file through the template file.<br>
     * 
     * @param filePath The file path used to save the file
     * @param controllerMap The input controller resource information
     * @throws ServiceException when read or write file have exception
     * @since SDNO 0.5
     */
    public static void buildControllerFile(String filePath, Map<String, Object> controllerMap) throws ServiceException {
        Map<String, Object> controllerTemplateMap = FileUtils.readJson(CONTROLLER_PATH);
        setTemplateMap(controllerMap, controllerTemplateMap);
        FileUtils.writeJson(filePath, controllerTemplateMap);
    }

    /**
     * Convert the commParam resource to standard json file through the template file.<br>
     * 
     * @param filePath The file path used to save the file
     * @param commParamMap The input commParam resource information
     * @throws ServiceException when read or write file have exception
     * @since SDNO 0.5
     */
    public static void buildCommParamFile(String filePath, Map<String, Object> commParamMap) throws ServiceException {
        Map<String, Object> commParamTemplateMap = FileUtils.readJson(COMM_PARAM_PATH);
        setTemplateMap(commParamMap, commParamTemplateMap);
        FileUtils.writeJson(filePath, commParamTemplateMap);
    }

    /**
     * Convert the networkElemen resource to standard json file through the template file.<br>
     * 
     * @param filePath The file path used to save the file
     * @param networkElementMap The input networkElemen resource information
     * @throws ServiceException when read or write file have exception
     * @since SDNO 0.5
     */
    public static void buildNetworkElementFile(String filePath, Map<String, Object> networkElementMap)
            throws ServiceException {
        Map<String, Object> networkElementTemplateMap = FileUtils.readJson(NETWORKELEMENT_PATH);
        setTemplateMap(networkElementMap, networkElementTemplateMap);
        FileUtils.writeJson(filePath, networkElementTemplateMap);
    }

    private static void setTemplateMap(Map<String, Object> inputResourceMap, Map<String, Object> templateMap) {
        for(String fieldName : inputResourceMap.keySet()) {
            if(templateMap.containsKey(fieldName)) {
                templateMap.put(fieldName, inputResourceMap.get(fieldName));
            }
        }
    }
}
