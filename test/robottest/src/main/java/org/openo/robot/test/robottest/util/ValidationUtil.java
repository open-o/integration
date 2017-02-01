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

package org.openo.robot.test.robottest.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.JSONException;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.robot.test.robottest.constants.AppConstants;

/**
 * The class to validate the input values.<br/>
 * <p>
 * </p>
 * 
 * @author
 * @version Integration 2.0 11-Jan-2017
 */
public class ValidationUtil {

    private InputStream inputStream;

    private String msb_ip;

    public static ValidationUtil instance = new ValidationUtil();

    ValidationUtil() {

    }

    /**
     * Get the instance of ValidationUtil class.<br/>
     * 
     * @return The object of validationUtil
     * @since Integration 2.0
     */
    public static ValidationUtil getInstance() {
        if(null == instance) {
            return new ValidationUtil();
        }

        return instance;
    }

    /**
     * Get the getiMSBValue from the config.properties file.<br/>
     * 
     * @return The getiMSBValue
     * @since Integration 2.0
     */
    public String getiMSBValue() {

        try {
            Properties prop = new Properties();
            String propFileName = "config.properties";

            inputStream = getClass().getClassLoader().getResourceAsStream(propFileName);

            if(inputStream != null) {
                try {
                    prop.load(inputStream);
                } catch(IOException e) {
                    e.printStackTrace();
                }
            } else {
                throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
            }

            msb_ip = prop.getProperty("msb_ip");
            System.out.println("MSB IP Address  " + msb_ip);

        } catch(Exception e) {
            System.out.println("Exception: " + e);
        }

        return msb_ip;
    }

    @SuppressWarnings({"unchecked", "unused"})
    public void setMSBValuetoJSONFile(String msb_ip) throws Exception {
        FileWriter file = null;
        JSONObject writeObject = null;
        File configFile = null;
        try {
            writeObject = new JSONObject();
            configFile = new File(AppConstants.CONFIGJSONPATH);
            file = new FileWriter(configFile);
            if(configFile != null) {
                writeObject.put(AppConstants.MSB_IP, msb_ip);
                file.write(writeObject.toJSONString());
                file.flush();
                file.close();
            } else {
                throw new FileNotFoundException(configFile.getName() + " not found in the classpath to write");
            }

        } catch(Exception e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                if(file != null)
                    file.close();
            } catch(Exception e) {
                System.out.println(e.getMessage());
            }
        }
    }

    public String getMSBValueFromJSONFile() throws ServiceException {
        JSONParser parser = null;
        Object msbObject = null;
        JSONObject readObject = null;
        String msb_ip = null;
        try {
            parser = new JSONParser();
            msbObject = parser.parse(new FileReader(AppConstants.CONFIGJSONPATH));

            if(msbObject != null) {
                readObject = (JSONObject)msbObject;
                msb_ip = (String)readObject.get(AppConstants.MSB_IP);
            } else {
                throw new JSONException("Data not available in the file " + AppConstants.CONFIGJSONPATH);
            }
        } catch(ParseException | IOException e) {
            System.out.println(e.getMessage());
        }
        return msb_ip;
    }

    /**
     * Replace the key format in the input JSON.<br/>
     * 
     * @param key The key name
     * @param JSON The JSON input
     * @return The Key with required format
     * @since Integration 2.0
     */
    public String getObject(String key, String JSON) {
        Pattern p = Pattern.compile(String.format("\"%s\":\"(.*?)\"", key));
        Matcher matcher = p.matcher(JSON);
        if(matcher.find()) {
            Pattern resource = Pattern.compile(String.format(":\"(.*?)\"", key));
            Matcher match = resource.matcher(matcher.group());
            if(match.find()) {
                return match.group().substring(1).replaceAll("\"", "");
            }
        }
        return null;
    }

}
