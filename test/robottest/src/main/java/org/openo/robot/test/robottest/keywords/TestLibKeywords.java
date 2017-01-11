
package org.openo.robot.test.robottest.keywords;

import java.util.HashMap;
import java.util.Map;

import org.openo.baseservice.remoteservice.exception.ServiceException;
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

import com.openo.robot.test.robottest.util.ValidationUtil;

import net.sf.json.JSONObject;

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
    public void replaceAndDoOperation(String queryPath, Map<String, String> mapValues) throws ServiceException {

        String msb_ip = ValidationUtil.getInstance().getiMSBValue();

        HttpRquestResponse httpObject = HttpModelUtils.praseHttpRquestResponseFromFile(queryPath);
        HttpRequest httpRequest = httpObject.getRequest();

        for(String key : mapValues.keySet()) {
            httpRequest.setUri(PathReplace.replaceUuid(key, httpRequest.getUri(), mapValues.get(key)));
        }

        HttpResponse createResponse = execTestCase(httpRequest, new JsonSchemaValidator(httpObject.getResponse()));
        JSONObject json = JSONObject.fromObject(createResponse.getData());

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
    public String doOperationAndGetValue(String queryPath, String variable) throws ServiceException {
        HttpRquestResponse httpCreateObject = HttpModelUtils.praseHttpRquestResponseFromFile(queryPath);
        HttpRequest createRequest = httpCreateObject.getRequest();
        HttpResponse createResponse =
                execTestCase(createRequest, new JsonSchemaValidator(httpCreateObject.getResponse()));

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
