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

package org.openo.sdno.testframework.checker;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.google.gson.Gson;

/**
 * Validate the json object.<br>
 * 
 * @author
 * @version SDNO 0.5 Aug 15, 2016
 */
public class Validator {

    Gson oGson = new Gson();

    /**
     * Constructor<br>
     * 
     * @since SDNO 0.5
     */
    public Validator() {
        // a empty constructor to construct a empty object.
    }

    /**
     * Compare two JSON objects, one expected JSON and other actual JSON<br>
     * 
     * @param expected -- expected JSON and mandatory fields to be compared.
     *            can be regular expressions
     * @param response -- actual JSON response
     * @return -- whether all fields present in input are matching or not.
     * @since SDNO 0.5
     */
    public boolean validate(Object expected, Object response) {

        // If both are strings and are not equal then return false
        if((expected instanceof String) && (response instanceof String)) {
            return matchPattern((String)expected, (String)response);
        } else {

            // Convert string to map (input/output)

            String expect = new Gson().toJson(expected);
            String rsp = new Gson().toJson(response);
            Map<String, Object> input = getMap(expect);
            Map<String, Object> output = getMap(rsp);

            // Compare each key of input to output, if match,
            // Check if object is instance of JSONObject, then get map
            for(String strInput : input.keySet()) {
                if(output.containsKey(strInput)) {
                    boolean isTrue = validate(input.get(strInput), output.get(strInput));
                    if(!isTrue) {
                        return false;
                    }
                }
            }
        }

        return true;
    }

    private Map<String, Object> getMap(String input) {

        Gson gson = new Gson();
        Map<String, Object> map = new HashMap<String, Object>();
        map = (Map<String, Object>)gson.fromJson(input, map.getClass());
        return map;
    }

    /**
     * This method is used to match the target string with a regular expression pattern. <br>
     * 
     * @param pattern The regular expression
     * @param target The string to verify
     * @since SDNO 0.5
     */
    private boolean matchPattern(String pattern, String target) {

        Matcher matcher = Pattern.compile(pattern).matcher(target);
        if(!matcher.find()) {
            return false;
        }

        return true;

    }
}
