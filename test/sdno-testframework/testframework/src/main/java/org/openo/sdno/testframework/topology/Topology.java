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
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.sdno.testframework.util.file.FileUtils;
import org.openo.sdno.testframework.util.file.JsonFileNameFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Topology Operation Class.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 17, 2016
 */
public class Topology {

    private static final Logger LOGGER = LoggerFactory.getLogger(Topology.class);

    private String topoFileDir;

    private TopologyOperation topoOperation;

    /**
     * Constructor<br>
     * 
     * @param topoFileDir topoFile Directory
     * @since SDNO 0.5
     */
    public Topology(String topoFileDir) {
        this.topoFileDir = topoFileDir;
        this.topoOperation = new TopologyOperation();
    }

    /**
     * Create Topology.<br>
     * 
     * @throws ServiceException when create topology failed
     * @since SDNO 0.5
     */
    public void createTopology() throws ServiceException {
        if(StringUtils.isBlank(topoFileDir)) {
            LOGGER.error("topoFile Dir parameter is invalid!!");
            throw new ServiceException("topoFileDir is invalid!!");
        }

        List<File> resFileList = FileUtils.listAllFiles(new File(this.topoFileDir), new JsonFileNameFilter());
        topoOperation.addResourceData(resFileList);
    }

    /**
     * Create Inventory Topology.<br>
     * 
     * @throws ServiceException when create topology failed
     * @since SDNO 0.5
     */
    public void createInvTopology() throws ServiceException {
        if(StringUtils.isBlank(topoFileDir)) {
            LOGGER.error("topoFile Dir parameter is invalid!!");
            throw new ServiceException("topoFileDir is invalid!!");
        }

        List<File> resFileList = FileUtils.listAllFiles(new File(this.topoFileDir), new JsonFileNameFilter());
        topoOperation.addInvResourceData(resFileList);
    }

    /**
     * Clear All Topology Resource Data.<br>
     * 
     * @throws ServiceException when clear topology failed
     * @since SDNO 0.5
     */
    public void clearTopology() throws ServiceException {
        topoOperation.removeResourceData();
    }

    /**
     * Clear All Inventory Topology Resource Data.<br>
     * 
     * @throws ServiceException when clear topology failed
     * @since SDNO 0.5
     */
    public void clearInvTopology() throws ServiceException {
        topoOperation.removeInvResourceData();
    }

    /**
     * Get resource uuid.<br>
     * 
     * @param resourceType resource type
     * @param resourceName resource name
     * @return resource uuid
     * @since SDNO 0.5
     */
    public String getResourceUuid(ResourceType resourceType, String resourceName) {
        return topoOperation.getResourceUuid(resourceType, resourceName);
    }
}
