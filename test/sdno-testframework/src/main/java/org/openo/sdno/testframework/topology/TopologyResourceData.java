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

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.sdno.testframework.util.JsonParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * TopoResourceData is used to store the informations retrieved from the JSON and CSV files. <br>
 * <p>
 * </p>
 * 
 * @author
 * @version SDNO 0.5 28-Jun-2016
 */
public class TopologyResourceData {

    private String url;

    private List<Map<String, String>> modifiableParameters;

    private Map<String, String> relationParameters;

    private Map<String, String> dataTemplate;

    private List<JSONObject> jsonList = new ArrayList<JSONObject>();

    private static final String URL_KEY = "url";

    private static final String DATA_KEY = "json";

    private static final String RELATION_KEY = "relation";

    private static final String COMMA = ",";

    private static final String RESULT_FOLDER_NAME = "\\Result";

    private static final String RESULT_FILE_NAME = "\\Element";

    private static final Logger LOGGER = LoggerFactory.getLogger(TopologyResourceData.class);

    /**
     * This method is used to get url <br>
     * 
     * @return url
     * @since SDNO 0.5
     */
    public String getUrl() {
        return url;
    }

    /**
     * This method is used to set url <br>
     * 
     * @param url
     * @since SDNO 0.5
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * This method is used to get modifiableParameters. <br>
     * 
     * @return modifiableParameters
     * @since SDNO 0.5
     */
    public List<Map<String, String>> getModifiableParameters() {
        return modifiableParameters;
    }

    /**
     * This method is used to set modifiableParameters.<br>
     * 
     * @param modifiableParameters
     * @since SDNO 0.5
     */
    public void setModifiableParameters(List<Map<String, String>> modifiableParameters) {
        this.modifiableParameters = modifiableParameters;
    }

    /**
     * This method is used to get relationParameters.<br>
     * 
     * @return relationParameters
     * @since SDNO 0.5
     */
    public Map<String, String> getRelationParameters() {
        return relationParameters;
    }

    /**
     * This method is used to set relationParameters<br>
     * 
     * @param relationParameters
     * @since SDNO 0.5
     */
    public void setRelationParameters(Map<String, String> relationParameters) {
        this.relationParameters = relationParameters;
    }

    /**
     * This method is used to get dataTemplate. <br>
     * 
     * @return dataTemplate
     * @since SDNO 0.5
     */
    public Map<String, String> getDataTemplate() {
        return dataTemplate;
    }

    /**
     * This method is used to set dataTemplate.<br>
     * 
     * @param dataTemplate The JSON data format.
     * @since SDNO 0.5
     */
    public void setDataTemplate(Map<String, String> dataTemplate) {
        this.dataTemplate = dataTemplate;
    }

    /**
     * This method is used to create the JSON objects and add them to the jsonList.<br>
     * 
     * @since SDNO 0.5
     */
    public void createJSONData() {
        modifyDataTemplate();
        addParametersToJSONObjects();

    }

    /**
     * This method is used to remove the relation parameters from the JSON data format.<br>
     * 
     * @since SDNO 0.5
     */
    private void modifyDataTemplate() {
        List<String> toRemove = new ArrayList<String>();
        for(Map.Entry<String, String> parameter : relationParameters.entrySet()) {
            for(Map.Entry<String, String> templateEntry : dataTemplate.entrySet()) {
                if(parameter.getValue().equals(templateEntry.getKey())) {
                    toRemove.add(templateEntry.getKey());
                }
            }
        }
        for(String key : toRemove) {
            dataTemplate.remove(key);
        }
    }

    /**
     * This method is used to add the modifiable parameters to the JSONObject.<br>
     * <br>
     * The JSON objects are created based on the list of modifiable parameters. Each JSONObject is
     * then added to the jsonList.
     * 
     * @since SDNO 0.5
     */
    private void addParametersToJSONObjects() {
        JsonParser jsonParser = new JsonParser();
        for(Map<String, String> parameters : modifiableParameters) {
            jsonParser.setJsonObject(new JSONObject(dataTemplate));
            for(Map.Entry<String, String> parameter : parameters.entrySet()) {
                jsonParser.modifyParameters(parameter.getKey(), parameter.getValue());
            }
            jsonList.add(jsonParser.getJsonObject());
        }
    }

    /**
     * This method is used to collect the parameters to be modified in the JSON file. This
     * information is retrieved from the CSV file. <br>
     * 
     * @param fileName The JSON file name is used to form the CSV file name.
     * @throws ServiceException
     * @since SDNO 0.5
     */
    private void retrieveModifiableParameters(File fileName) throws ServiceException {
        List<Map<String, String>> parameterList = new ArrayList<Map<String, String>>();
        File csvFilePath = getCsvFilePath(fileName);
        String line = "";
        boolean firstLine = true;
        try (BufferedReader br = new BufferedReader(new FileReader(csvFilePath))) {
            String[] header = null;
            while((line = br.readLine()) != null) {
                Map<String, String> params = new HashMap<String, String>();
                if(firstLine) {
                    header = line.split(COMMA);
                    firstLine = false;
                } else {
                    int count = 0;
                    String[] parameters = line.split(COMMA);
                    for(String key : header) {
                        params.put(key, parameters[count]);
                        count++;
                    }
                    parameterList.add(params);
                }
            }
        } catch(IOException e) {
            LOGGER.error("An I/O error has occured while retrieving the CSV file.", e);
            throw new ServiceException("An I/O error has occured while retrieving the CSV file. ");
        }
        modifiableParameters = parameterList;
    }

    /**
     * This method is used to retrieve the following informations from the JSON template file and
     * the CSV file:
     * 1. URL,
     * 2. Relation parameters,
     * 3. JSON data format,
     * 4. Parameters to be modified <br>
     * 
     * @param fileName The JSON template file.
     * @return Returns the TopoResourceData Object. It contains the entire data read from the JSON
     *         template file and the CSV file.
     * @throws ServiceException
     * @since SDNO 0.5
     */
    @SuppressWarnings("unchecked")
    public static TopologyResourceData retrieveTopoResourceData(File fileName) throws ServiceException {
        TopologyResourceData topoResourceData = new TopologyResourceData();
        JsonParser jsonPraser = new JsonParser();
        JSONObject json = jsonPraser.loadJson(fileName.toString());
        topoResourceData.setUrl((String)json.get(URL_KEY));
        topoResourceData.setRelationParameters((Map<String, String>)json.get(RELATION_KEY));
        topoResourceData.setDataTemplate((Map<String, String>)json.get(DATA_KEY));
        topoResourceData.retrieveModifiableParameters(fileName);
        return topoResourceData;
    }

    /**
     * This method is used to create the CSV file path from the JSON file path. <br>
     * 
     * @param fileName
     *            The JSON file path
     * @return The CSV file path
     * @since SDNO 0.5
     */
    private File getCsvFilePath(File fileName) {
        String file = fileName.getName();
        String filepath = file.replace(".json", ".csv");
        return new File(fileName.getParent(), filepath);
    }

    /**
     * This method is used to write all the JSON objects into a file. <br>
     * 
     * @param count To uniquely identify the JSON files.
     * @since SDNO 0.5
     */
    @SuppressWarnings("unchecked")
    public void writeJSONData(int count) {
        String resultFilePath = System.getProperty("user.dir") + RESULT_FOLDER_NAME;
        new File(resultFilePath).mkdir();

        JSONObject json = new JSONObject();
        JSONArray jsonArray = new JSONArray();
        jsonArray.addAll(jsonList);
        json.put(DATA_KEY, jsonArray);
        resultFilePath = resultFilePath + RESULT_FILE_NAME + count + ".json";
        JsonParser.writeJsonToFile(json, resultFilePath);

    }
}
