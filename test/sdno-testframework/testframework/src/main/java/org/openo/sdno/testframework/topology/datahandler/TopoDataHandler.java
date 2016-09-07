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

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.sdno.testframework.restclient.HttpRestClient;
import org.openo.sdno.testframework.topology.TopologyResourceCache;

/**
 * Base class of Topology Data Handler.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 20, 2016
 */
public abstract class TopoDataHandler {

    protected static final String NAME_KEY = "name";

    protected static final String ID_KEY = "id";

    protected TopologyResourceCache dataCache;

    protected List<File> processFileList = new ArrayList<File>();

    protected HttpRestClient restClient = new HttpRestClient();

    public final void setDataCache(TopologyResourceCache dataCache) {
        this.dataCache = dataCache;
    }

    /**
     * Add Resource Data.<br>
     * 
     * @param file File Object
     * @since SDNO 0.5
     */
    public abstract void addResource(File file) throws ServiceException;

    /**
     * Remove all Resource Data.<br>
     * 
     * @since SDNO 0.5
     */
    public abstract void removeResource() throws ServiceException;

    /**
     * Add All Resource.<br>
     * 
     * @throws ServiceException throws when failed
     * @since SDNO 0.5
     */
    public final void processAddResource() throws ServiceException {
        for(File file : processFileList) {
            addResource(file);
        }
    }

    /**
     * Remove All Resource.<br>
     * 
     * @throws ServiceException throws when failed
     * @since SDNO 0.5
     */
    public final void processRemoveResource() throws ServiceException {
        removeResource();
    }

    /**
     * Add Process File.<br>
     * 
     * @param file file need to process
     * @since SDNO 0.5
     */
    public final void addProcessFile(File file) {
        processFileList.add(file);
    }

    /**
     * Remove all Process File.<br>
     * 
     * @since SDNO 0.5
     */
    public final void removeAllProcessFile() {
        processFileList.clear();
    }
}
