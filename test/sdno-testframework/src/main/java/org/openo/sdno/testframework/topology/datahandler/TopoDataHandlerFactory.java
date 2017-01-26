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

package org.openo.sdno.testframework.topology.datahandler;

import org.openo.sdno.testframework.topology.ResourceType;
import org.openo.sdno.testframework.topology.TopologyResourceCache;

/**
 * Class of DataHandler of Factory.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 22, 2016
 */
public class TopoDataHandlerFactory {

    private static TopoDataHandlerFactory instance = new TopoDataHandlerFactory();

    /**
     * Get Singleton Instance of TopoDataHandlerFactory.<br>
     * 
     * @return Singleton Instance of TopoDataHandlerFactory
     * @since SDNO 0.5
     */
    public static TopoDataHandlerFactory getInstance() {
        return instance;
    }

    /**
     * Create Data Handler.<br>
     * 
     * @param resourceType resource type
     * @param dataCache data cache
     * @return TopoDataHandler created
     * @since SDNO 0.5
     */
    public TopoDataHandler createDataHandler(ResourceType resourceType, TopologyResourceCache dataCache) {
        TopoDataHandler dataHandler = null;

        if(ResourceType.CONTROLLER.equals(resourceType)) {
            dataHandler = new ControllerDataHandler();
        } else if(ResourceType.COMM_PARAM.equals(resourceType)) {
            dataHandler = new CommParamDataHandler();
        } else if(ResourceType.SITE.equals(resourceType)) {
            dataHandler = new SiteDataHandler();
        } else if(ResourceType.NETWORKELEMENT.equals(resourceType)) {
            dataHandler = new NetworkElementDataHandler();
        } else if(ResourceType.LOGICALTERMINATIONPOINT.equals(resourceType)) {
            dataHandler = new LogicalTPDataHandler();
        }

        if(null != dataHandler) {
            dataHandler.setDataCache(dataCache);
        }

        return dataHandler;
    }

}
