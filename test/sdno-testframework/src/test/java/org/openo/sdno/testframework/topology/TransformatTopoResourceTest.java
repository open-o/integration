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

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.sdno.testframework.util.file.JsonUtil;

public class TransformatTopoResourceTest {

    private static final String TESTTOPODATA_PATH = "src/test/resources/testtopodata";

    @Before
    public void setup() throws ServiceException {
    }

    @After
    public void tearDown() {
    }

    @Test
    public void testTransformatTopoResource() throws Exception {
        final String controllerFileName = "/controller.json";
        final String commparamFileName = "/commparam.json";
        final String neFileName = "/networkelement.json";
        Map<String, Object> controllerMap = new HashMap<String, Object>();
        controllerMap.put("name", "ACController");
        controllerMap.put("hostName", "1.2.3.4");
        controllerMap.put("description", "private controller");
        TransformatTopoResource.buildControllerFile(TESTTOPODATA_PATH + controllerFileName, controllerMap);

        final Map<String, Object> commParamMap = new HashMap<String, Object>();
        Map<String, Object> commParamsMap = new HashMap<String, Object>();
        commParamsMap.put("username", "admin");
        commParamsMap.put("password", "Changeme_123");
        commParamsMap.put("orgnization", "huawei");
        commParamsMap.put("transProtocol", "https");
        commParamMap.put("commParams", JsonUtil.toJson(commParamsMap));
        commParamMap.put("name", "ControllerCommParam");
        commParamMap.put("port", 23);
        commParamMap.put("hostName", "slsidn.ssaid.com");
        commParamMap.put("metaModelId", "rest_csm-v1");
        commParamMap.put("controllerName", "ACController");
        TransformatTopoResource.buildCommParamFile(TESTTOPODATA_PATH + commparamFileName, commParamMap);

        Map<String, Object> neMap = new HashMap<String, Object>();
        neMap.put("name", "Networkwork");
        neMap.put("version", "V1R3");
        neMap.put("controllerName", "ACController");
        TransformatTopoResource.buildNetworkElementFile(TESTTOPODATA_PATH + neFileName, neMap);

        showBuildResult(controllerFileName);
        showBuildResult(commparamFileName);
        showBuildResult(neFileName);
    }

    @Test
    public void testbuildControllerFile() throws Exception {
        final String controllerFileName = "/controller.json";
        Map<String, Object> controllerMap = new HashMap<String, Object>();
        controllerMap.put("name", "snc1");
        controllerMap.put("controllerType", "SNC");
        controllerMap.put("hostName", "1.2.3.4");
        controllerMap.put("description", "private controller");
        TransformatTopoResource.buildControllerFile(TESTTOPODATA_PATH + controllerFileName, controllerMap);
        showBuildResult(controllerFileName);
    }

    @Test
    public void testBuildCommParamFile() throws Exception {
        final String commparamFileName = "/commparam.json";
        final Map<String, Object> commParamMap = new HashMap<String, Object>();
        Map<String, Object> commParamsMap = new HashMap<String, Object>();
        commParamsMap.put("username", "admin");
        commParamsMap.put("password", "Changeme_123");
        commParamsMap.put("orgnization", "huawei");
        commParamsMap.put("transProtocol", "https");
        commParamMap.put("commParams", JsonUtil.toJson(commParamsMap));
        commParamMap.put("port", 23);
        commParamMap.put("hostName", "slsidn.ssaid.com");
        commParamMap.put("metaModelId", "rest_csm-v1");
        commParamMap.put("controllerName", "snc1");
        TransformatTopoResource.buildCommParamFile(TESTTOPODATA_PATH + commparamFileName, commParamMap);

        showBuildResult(commparamFileName);
    }

    @Test
    public void testBuildNetworkElementFile() throws Exception {
        final String neFileName = "/networkelement.json";
        Map<String, Object> neMap = new HashMap<String, Object>();
        neMap.put("name", "ne1");
        neMap.put("version", "v1r3");
        neMap.put("controllerName", "snc1");
        neMap.put("siteName", "site1");
        TransformatTopoResource.buildNetworkElementFile(TESTTOPODATA_PATH + neFileName, neMap);

        showBuildResult(neFileName);
    }

    private void showBuildResult(String resourceFileName) throws FileNotFoundException, IOException {
        File file = new File(TESTTOPODATA_PATH + resourceFileName);
        FileInputStream fileStream = new FileInputStream(file);
        String jsonString = IOUtils.toString(fileStream);
        System.out.println(jsonString);
    }
}
