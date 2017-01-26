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

import java.util.HashMap;
import java.util.Map;

/**
 * Class of Topology Resource Data Cache.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 21, 2016
 */
public class TopologyResourceCache {

    /**
     * Resource-Name-Id Map
     */
    private Map<ResourceType, Map<String, String>> resourceMap = new HashMap<ResourceType, Map<String, String>>();

    /**
     * Get data map by resource type.<br>
     * 
     * @param resourcetype resource type
     * @return data map
     * @since SDNO 0.5
     */
    public Map<String, String> getDataMapbyResouceType(ResourceType resourcetype) {
        synchronized(resourceMap) {
            return resourceMap.get(resourcetype);
        }
    }

    /**
     * Add resource uuid to Map.<br>
     * 
     * @param resourcetype resource type
     * @param resourceName resource name
     * @param uuid resource id
     * @since SDNO 0.5
     */
    public void addUUIDToMap(ResourceType resourcetype, String resourceName, String uuid) {
        synchronized(resourceMap) {
            Map<String, String> dataMap = getDataMapbyResouceType(resourcetype);
            if(null == dataMap) {
                dataMap = new HashMap<String, String>();
                resourceMap.put(resourcetype, dataMap);
            }
            dataMap.put(resourceName, uuid);
        }
    }

    /**
     * Get uuid by name.<br>
     * 
     * @param resourcetype resource type
     * @param resourceName resource name
     * @return resource uuid
     * @since SDNO 0.5
     */
    public String getUUIDbyName(ResourceType resourcetype, String resourceName) {
        synchronized(resourceMap) {
            Map<String, String> dataMap = getDataMapbyResouceType(resourcetype);
            if(null == dataMap) {
                return null;
            }
            return dataMap.get(resourceName);
        }
    }

    /**
     * Remove resource from cache.<br>
     * 
     * @param resourcetype resource type
     * @since SDNO 0.5
     */
    public void removeResourceData(ResourceType resourcetype) {
        synchronized(resourceMap) {
            resourceMap.remove(resourcetype);
        }
    }
}
