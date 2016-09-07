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

package org.openo.sdno.testframework.util.file;

import java.io.File;
import java.io.FilenameFilter;

/**
 * JSON File Name Filter Class.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 20, 2016
 */
public class JsonFileNameFilter implements FilenameFilter {

    private static final String JSON_FILE_FORMAT = ".json";

    /**
     * File Name Filter.<br>
     * 
     * @param dir File Directory
     * @param name filename
     * @return true if filename matched
     * @since SDNO 0.5
     */
    @Override
    public boolean accept(File dir, String name) {
        return (!name.contains(".")) || name.endsWith(JSON_FILE_FORMAT);
    }

}
