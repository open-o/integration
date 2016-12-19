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
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Util class of File Operation.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 20, 2016
 */
public class FileUtils {

    private static final Logger LOGGER = LoggerFactory.getLogger(FileUtils.class);

    private FileUtils() {

    }

    /**
     * Get all files from the root directory file through the name filter.<br>
     * 
     * @param rootDirFile the root directory file
     * @param nameFilter the file name filter
     * @return The list of the files
     * @since SDNO 0.5
     */
    public static List<File> listAllFiles(File rootDirFile, FilenameFilter nameFilter) {
        List<File> fileList = new ArrayList<File>();
        File[] rootFileList = rootDirFile.listFiles(nameFilter);
        for(File currentFile : rootFileList) {
            if(currentFile.isDirectory()) {
                fileList.addAll(listAllFiles(currentFile, nameFilter));
            } else {
                fileList.add(currentFile);
            }
        }

        return fileList;
    }

    /**
     * Read the json file to a map.<br>
     * 
     * @param path The json file path
     * @return The map of the file parameters
     * @since SDNO 0.5
     */
    @SuppressWarnings({"unchecked", "deprecation"})
    public static Map<String, Object> readJson(String path) throws ServiceException {
        try {
            FileInputStream fileStream = new FileInputStream(new File(path));

            String jsonString = IOUtils.toString(fileStream);
            return JsonUtil.fromJson(jsonString, Map.class);
        } catch(IOException e) {
            LOGGER.error("Read from file in path failed!!", e);
            throw new ServiceException("Read from file in path failed!!", e);
        }
    }

    /**
     * Read parameter from json file.<br>
     * 
     * @param file The json file
     * @return The parameters in json as string
     * @since SDNO 0.5
     */
    public static String readFromJson(File file) throws ServiceException {
        try {
            FileInputStream fileStream = new FileInputStream(file);
            return IOUtils.toString(fileStream);
        } catch(IOException e) {
            LOGGER.error("Read from json file failed!!", e);
            throw new ServiceException("Read from json file failed!!", e);
        }
    }

    /**
     * Write resource map to json file.<br>
     * 
     * @param filePath The json file path
     * @param resourceMap The resource Map
     * @since SDNO 0.5
     */
    public static void writeJson(String filePath, Map<String, Object> resourceMap) throws ServiceException {
        try {
            List<Map<String, Object>> resourceList = new ArrayList<Map<String, Object>>();
            resourceList.add(resourceMap);
            String josnStr = JsonUtil.toJson(resourceList);
            FileWriter fileWrite = new FileWriter(filePath);
            PrintWriter outFile = new PrintWriter(fileWrite);
            outFile.write(josnStr);
            fileWrite.close();
            outFile.close();
        } catch(IOException e) {
            LOGGER.error("write to json file failed!!", e);
            throw new ServiceException("write to json file failed!!", e);
        }
    }
}
