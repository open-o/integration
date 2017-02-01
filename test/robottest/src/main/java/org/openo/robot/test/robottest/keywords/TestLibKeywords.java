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

package org.openo.robot.test.robottest.keywords;

import java.util.HashMap;
import java.util.Map;

import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.robot.test.robottest.constants.AppConstants;
import org.openo.robot.test.robottest.util.ValidationUtil;
import org.openo.sdno.testframework.checker.JsonSchemaValidator;
import org.openo.sdno.testframework.http.model.HttpModelUtils;
import org.openo.sdno.testframework.http.model.HttpRequest;
import org.openo.sdno.testframework.http.model.HttpResponse;
import org.openo.sdno.testframework.http.model.HttpRquestResponse;
import org.openo.sdno.testframework.replace.PathReplace;
import org.openo.sdno.testframework.testmanager.TestManager;
import org.openo.sdno.testframework.topology.Topology;
import org.robotframework.javalib.annotation.ArgumentNames;
import org.robotframework.javalib.annotation.RobotKeyword;
import org.robotframework.javalib.annotation.RobotKeywords;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Keywords to for REST test framework.<br/>
 * <p>
 * </p>
 * 
 * @author
 * @version Integration 2.0 11-Jan-2017
 */
@RobotKeywords
public class TestLibKeywords extends TestManager {

    Map<String, Topology> mapOfTopology = new HashMap<String, Topology>();

    private static final Logger logger = LoggerFactory.getLogger(TestLibKeywords.class);

    /**
     * This keyword is for writing MSB in config.properties
     * Set the config.properties file with MSB_IP<br/>
     * 
     * @param msb_ip The input MSB_IP
     * @since Integration 2.0
     */
    @RobotKeyword("Set MSB Value")
    @ArgumentNames({"msbip"})
    public void setMSBValue(String msb_ip) {
        try {
            ValidationUtil.getInstance().setMSBValuetoJSONFile(msb_ip);
        } catch(Exception e) {
            logger.error(e.getMessage());
        }
    }

    /**
     * Replace given variables with values and send REST operation and validate and return
     * value.<br/>
     * 
     * @param queryPath The input test JSON file path
     * @param variable - variable to be replace
     * @param value The real value of MSB_IP to replace in input JSON
     * @return
     * @throws ServiceException
     * @since Integration 2.0
     */

    @RobotKeyword("Replace variables and send REST")
    @ArgumentNames({"queryPath", "mapValues"})
    public void replaceVariablesAndSendREST(String queryPath, Map<String, String> mapValues) throws ServiceException {

        HttpRquestResponse httpObject = HttpModelUtils.praseHttpRquestResponseFromFile(queryPath);
        HttpRequest httpRequest = httpObject.getRequest();

        replaceVariablesInURI(httpRequest, mapValues);
        execTestCase(httpRequest, new JsonSchemaValidator(httpObject.getResponse()));

        return;

    }

    private void replaceVariablesInURI(HttpRequest httpRequest, Map<String, String> mapValues) throws ServiceException {

        if(null == mapValues) {
            mapValues = new HashMap<String, String>();
        }

        String msb_ip = ValidationUtil.getInstance().getMSBValueFromJSONFile();
        mapValues.put(AppConstants.MSB_IP, msb_ip);

        for(String key : mapValues.keySet()) {
            httpRequest.setUri(PathReplace.replaceUuid(key, httpRequest.getUri(), mapValues.get(key)));
        }

        return;
    }

    /**
     * Get the response of restful call<br/>
     * 
     * @param queryPath The input JSON file
     * @param variable The uri key value from input JSON
     * @return Response of restful call
     * @throws ServiceException
     * @since Integration 2.0
     */
    @RobotKeyword("Send REST and get Value")
    @ArgumentNames({"queryPath", "variable"})
    public String sendRESTandGetValue(String queryPath, String variable) throws ServiceException {
        HttpRquestResponse httpCreateObject = HttpModelUtils.praseHttpRquestResponseFromFile(queryPath);
        HttpRequest httpRequest = httpCreateObject.getRequest();

        replaceVariablesInURI(httpRequest, null);
        HttpResponse createResponse =
                execTestCase(httpRequest, new JsonSchemaValidator(httpCreateObject.getResponse()));

        String strValue = ValidationUtil.getInstance().getObject(variable, createResponse.getData());

        return strValue;

    }

    /**
     * Create topology with the given resources( Ex-NetworkElements, Controllers, Nodes, etc)<br/>
     * 
     * @param topoPath The Topology Directory path
     * @since Integration 2.0
     */

    @RobotKeyword("Create resource in database")
    @ArgumentNames({"topoPath"})
    public void createTopology(String topoPath) {

        try {

            if(null != mapOfTopology) {
                Topology topo = mapOfTopology.get(topoPath);
                if(null == topo) {
                    topo = new Topology(topoPath);
                    mapOfTopology.put(topoPath, topo);
                }

                topo.createInvTopology();
            }

        } catch(ServiceException e) {

            e.printStackTrace();
        }

    }

    /**
     * Clear the existing resources.<br>
     * 
     * @param topoPath The resources Directory path
     * @since Integration 2.0
     */
    @RobotKeyword("Clear resource from database")
    @ArgumentNames({"topoPath"})
    public void clearTopology(String topoPath) {

        if(null != mapOfTopology) {
            Topology topo = mapOfTopology.get(topoPath);
            if(null == topo) {
                topo = new Topology(topoPath);
                mapOfTopology.put(topoPath, topo);
            }

            try {
                topo.clearInvTopology();
            } catch(ServiceException e) {

                e.printStackTrace();
            }
        }

    }
}
