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

import java.io.IOException;
import java.util.Iterator;

import org.openo.sdno.testframework.http.model.HttpResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonNode;
import com.github.fge.jsonschema.exceptions.ProcessingException;
import com.github.fge.jsonschema.main.JsonSchema;
import com.github.fge.jsonschema.main.JsonSchemaFactory;
import com.github.fge.jsonschema.report.ProcessingMessage;
import com.github.fge.jsonschema.report.ProcessingReport;
import com.github.fge.jsonschema.util.JsonLoader;
import com.google.gson.Gson;

/**
 * The checker of regular.<br>
 * 
 * @author
 * @version SDNO 0.5 Aug 15, 2016
 */
public class JsonSchemaValidator implements IChecker {

    private static final Logger LOGGER = LoggerFactory.getLogger(JsonSchemaValidator.class);

    Gson oGson = new Gson();

    private HttpResponse expectedResponse;

    /**
     * Constructor.<br>
     * 
     * @param response The expected response
     * @since SDNO 0.5
     */
    public JsonSchemaValidator(HttpResponse response) {
        expectedResponse = response;
    }

    /**
     * Set excepted response.<br>
     * 
     * @param response The excepted response to set
     * @since SDNO 0.5
     */
    public void setResponse(HttpResponse response) {
        expectedResponse = response;
    }

    // Regular expression checker
    @Override
    public boolean check(HttpResponse response) {
        if(response.getStatus() != expectedResponse.getStatus()) {
            return false;
        }

        // If expected response is null -- no need to match anything, only check status
        if(null == expectedResponse.getJson()) {
            return true;
        }

        // Something is expected but nothing came, some problem, test case failed
        if(null == response.getData()) {
            return false;
        }

        String rsp = new Gson().toJson(expectedResponse.getJson());

        return validate(response.getData(), rsp);
    }

    public boolean validate(String jsonData, String jsonSchema) {
        ProcessingReport report = null;
        boolean result = false;
        try {
            // "Applying schema: @<@<" + jsonSchema + ">@>@ to data: #<#<" + jsonData + ">#>#"
            JsonNode schemaNode = JsonLoader.fromString(jsonSchema);
            JsonNode data = JsonLoader.fromString(jsonData);
            JsonSchemaFactory factory = JsonSchemaFactory.byDefault();
            JsonSchema schema = factory.getJsonSchema(schemaNode);
            report = schema.validate(data);
        } catch(JsonParseException jpex) {
            LOGGER.error("Error. Something went wrong trying to parse json data: #<#<" + jsonData
                    + ">#># or json schema: @<@<" + jsonSchema + ">@>@. Are the double quotes included? "
                    + jpex.getMessage());

        } catch(ProcessingException pex) {
            LOGGER.error("Error. Something went wrong trying to process json data: #<#<" + jsonData
                    + ">#># with json schema: @<@<" + jsonSchema + ">@>@ " + pex.getMessage());

        } catch(IOException e) {
            LOGGER.error("Error. Something went wrong trying to read json data: #<#<" + jsonData
                    + ">#># or json schema: @<@<" + jsonSchema + ">@>@");

        }
        if(report != null) {
            Iterator<ProcessingMessage> iter = report.iterator();
            while(iter.hasNext()) {
                ProcessingMessage pm = iter.next();
                LOGGER.info("Processing Message: " + pm.getMessage());
            }
            result = report.isSuccess();
        }

        LOGGER.info(" Result=" + result);

        return result;
    }

}
