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

/**
 * Type of InventoryResource.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 20, 2016
 */
public enum ResourceType {
    CONTROLLER("Controller"), COMM_PARAM("CommParam"), SITE("Site"), NETWORKELEMENT("NetworkElement"),
    LOGICALTERMINATIONPOINT("LogicalTerminationPoint");

    private String resourceTypeName;

    /**
     * Constructor<br>
     * 
     * @param resourceTypeName resource type name
     * @param processPriority process priority
     * @since SDNO 0.5
     */
    ResourceType(String resourceTypeName) {
        this.resourceTypeName = resourceTypeName;
    }

    /**
     * Get Resource type by Name.<br>
     * 
     * @param name resource name
     * @return resource type
     * @since SDNO 0.5
     */
    public static ResourceType getResourceTypebyName(String name) {
        if(name.startsWith(CONTROLLER.resourceTypeName)) {
            return CONTROLLER;
        } else if(name.startsWith(COMM_PARAM.resourceTypeName)) {
            return COMM_PARAM;
        } else if(name.startsWith(SITE.resourceTypeName)) {
            return SITE;
        } else if(name.startsWith(NETWORKELEMENT.resourceTypeName)) {
            return NETWORKELEMENT;
        } else if(name.startsWith(LOGICALTERMINATIONPOINT.resourceTypeName)) {
            return LOGICALTERMINATIONPOINT;
        }
        return null;
    }
}
