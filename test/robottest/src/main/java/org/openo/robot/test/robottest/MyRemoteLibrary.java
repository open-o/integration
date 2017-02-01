/*
 * Copyright 2016-2017 Huawei Technologies Co., Ltd.
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

package org.openo.robot.test.robottest;

import org.robotframework.javalib.library.AnnotationLibrary;
import org.robotframework.remoteserver.RemoteServer;

/**
 * The class to connect to remote machine and execute methods with input keywords.<br/>
 * <p>
 * </p>
 * 
 * @author
 * @version Integration 2.0 11-Jan-2017
 */
public class MyRemoteLibrary extends AnnotationLibrary {

    public MyRemoteLibrary() {
        super("org/openo/robot/test/robottest/keywords/*.class");
    }

    @Override
    public String getKeywordDocumentation(String keywordName) {
        if(keywordName.equals("__intro__")) {
            return "Intro";
        }

        return super.getKeywordDocumentation(keywordName);
    }

    /**
     * Connect to the remote machine with remote sever. <br/>
     * 
     * @param args
     * @throws Exception
     * @since Integration 2.0
     */
    public static void main(String[] args) throws Exception {
        RemoteServer.configureLogging();
        RemoteServer server = new RemoteServer();
        server.addLibrary(MyRemoteLibrary.class, 8271);
        server.start();
    }

}
