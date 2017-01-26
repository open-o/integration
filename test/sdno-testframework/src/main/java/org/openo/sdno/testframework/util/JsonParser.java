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

package org.openo.sdno.testframework.util;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.Set;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.Gson;

/**
 * Used to modify JSON file and JSONObject <br>
 * 
 * @author
 * @version SDNO 0.5 21-Jun-2016
 */
public class JsonParser {

    private JSONObject jsonObject;

    private static final Logger LOGGER = LoggerFactory.getLogger(JsonParser.class);

    /**
     * This method is used to load from the JSON file and returns the
     * JSONObject. <br>
     * 
     * @param fileName The name of the JSON file with complete path.
     * @return It returns the JSONObject
     * @since SDNO 0.5
     */
    public JSONObject loadJson(String fileName) {
        try {
            jsonObject = (JSONObject)new JSONParser().parse(new FileReader(fileName));
        } catch(FileNotFoundException e) {
            LOGGER.error("Not able to find the JSON file " + fileName, e);
        } catch(IOException e) {
            LOGGER.error("Not able to read from the JSON file " + fileName, e);
        } catch(ParseException e) {
            LOGGER.error("Not able to parse the json values from the JSON file " + fileName, e);
        }
        return jsonObject;
    }

    /**
     * This method is used to write the JSONObject to a JSON file.<br>
     * 
     * @param jsonObject The json object
     * @param fileName The name of the JSON file with complete path
     * @since SDNO 0.5
     */
    public static void writeJsonToFile(JSONObject jsonObject, String fileName) {
        FileWriter jsonFile = null;
        try {
            jsonFile = new FileWriter(fileName);
            jsonFile.write(jsonObject.toJSONString());
            jsonFile.flush();
            jsonFile.close();
        } catch(IOException e) {
            LOGGER.error("Not able to write into the JSON file " + fileName, e);
        }
    }

    /**
     * This method is used to return the JSONObject. <br>
     * 
     * @return The JSONObject
     * @since SDNO 0.5
     */
    public JSONObject getJsonObject() {
        return jsonObject;
    }

    /**
     * This method is used to set the JSONObject. <br>
     * 
     * @param jsonObject The JSON Object
     * @since SDNO 0.5
     */
    public void setJsonObject(JSONObject jsonObject) {
        this.jsonObject = jsonObject;
    }

    /**
     * This method is used to modify a parameter from the JSONObject. <br>
     * 
     * @param key The key to be used.
     * @param value The value to be used.
     * @since SDNO 0.5
     */
    @SuppressWarnings("unchecked")
    public void modifyParameters(String key, Object value) {
        if(value == null) {
            LOGGER.info(" The value passed to the method is null.");
        } else if(value instanceof String) {
            modifyStringValue(key, (String)value);
        } else if(value instanceof List) {
            modifyListValue(key, (List<String>)value);
        } else {
            modifyObject(key, (Object)value);
        }
    }

    @SuppressWarnings("unchecked")
    private void modifyStringValue(String key, String value) {
        Set<String> keys = jsonObject.keySet();
        for(String keyString : keys) {
            if(keyString.equals(key)) {
                jsonObject.put(keyString, value);
            }
        }
    }

    @SuppressWarnings("unchecked")
    private void modifyListValue(String key, List<String> value) {
        Set<String> keys = jsonObject.keySet();
        for(String keyString : keys) {
            if(keyString.equals(key)) {
                jsonObject.put(keyString, value);
            }
        }
    }

    @SuppressWarnings("unchecked")
    private void modifyObject(String key, Object value) {
        Set<String> keys = jsonObject.keySet();
        for(String keyString : keys) {
            if(keyString.equals(key)) {
                String json = new Gson().toJson(value);
                JSONObject jsonObj = null;
                try {
                    jsonObj = (JSONObject)new JSONParser().parse(json);
                } catch(ParseException e) {
                    LOGGER.error("Not able to parse the json values", e);
                }
                jsonObject.put(keyString, jsonObj);
            }
        }

    }
}
