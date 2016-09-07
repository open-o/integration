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
import java.util.ArrayList;
import java.util.List;

import org.openo.baseservice.remoteservice.exception.ServiceException;

/**
 * TopoResourceManager Class <br>
 * 
 * @author
 * @version SDNO 0.5 28-Jun-2016
 */
public class TopologyResourceManager {

    private List<TopologyResourceData> topoResources;

    /**
     * This method is used to get topoResources.<br>
     * 
     * @return
     * @since SDNO 0.5
     */
    public List<TopologyResourceData> getTopoResources() {
        return topoResources;
    }

    /**
     * This method is used to set topoResources. <br>
     * 
     * @param topoResources
     * @since SDNO 0.5
     */
    public void setTopoResources(List<TopologyResourceData> topoResources) {
        this.topoResources = topoResources;
    }

    /**
     * This method is used to retrieve the information from the JSON and CSV files and store it in
     * TopoResourceData.<br>
     * 
     * @param jsonFileNames
     * @return topoResources
     * @throws ServiceException
     * @since SDNO 0.5
     */
    public List<TopologyResourceData> retrieveTopoResources(List<File> jsonFileNames) throws ServiceException {
        List<TopologyResourceData> topoResourcesList = new ArrayList<TopologyResourceData>();
        for(File jsonFile : jsonFileNames) {
            TopologyResourceData topoResourceData = TopologyResourceData.retrieveTopoResourceData(jsonFile);
            topoResourcesList.add(topoResourceData);
        }
        return topoResourcesList;
    }

    /**
     * This method is used to create the JSON objects for each TopoResourceData. <br>
     * 
     * @since SDNO 0.5
     */
    public void createJsonResources() {
        for(TopologyResourceData topoResourceData : topoResources) {
            topoResourceData.createJSONData();
        }
    }

    /**
     * This method is used to write all the JSON objects present in each TopoResourceData into JSON
     * files.<br>
     * 
     * @since SDNO 0.5
     */
    public void writeJsonResources() {
        int count = 1;
        for(TopologyResourceData topoResourceData : topoResources) {
            topoResourceData.writeJSONData(count);
            count++;
        }
    }
}
