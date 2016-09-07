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

package org.openo.sdno.testframework.moco;

import static com.github.dreamhead.moco.Runner.runner;

import org.openo.baseservice.remoteservice.exception.ServiceException;
import org.openo.sdno.testframework.config.ServerConfiguration;
import org.openo.sdno.testframework.http.model.HttpModelUtils;
import org.openo.sdno.testframework.http.model.HttpRquestResponse;
import org.openo.sdno.testframework.moco.requestmacher.RequestMatcherUtils;
import org.openo.sdno.testframework.moco.responsehandler.MocoResponseHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.github.dreamhead.moco.HttpServer;
import com.github.dreamhead.moco.RequestMatcher;
import com.github.dreamhead.moco.ResponseHandler;
import com.github.dreamhead.moco.Runner;

/**
 * Class of MocoServer.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 15, 2016
 */
public abstract class MocoServer {

    private static final Logger LOGGER = LoggerFactory.getLogger(MocoServer.class);

    protected Runner runner;

    protected HttpServer server;

    protected ServerConfiguration serverConfig = new ServerConfiguration();

    /**
     * Constructor<br>
     * 
     * @since SDNO 0.5
     */
    public MocoServer() {
        server = createServer();
        runner = runner(server);
    }

    /**
     * Constructor<br>
     * 
     * @param port Server listening port
     * @since SDNO 0.5
     */
    public MocoServer(int port) {
        server = createServer(port);
        runner = runner(server);
    }

    /**
     * Start Moco Server.<br>
     * 
     * @since SDNO 0.5
     */
    public final void start() throws ServiceException {
        if(null != runner) {
            addRequestResponsePairs();
            runner.start();
        }
    }

    /**
     * Stop Moco Server.<br>
     * 
     * @since SDNO 0.5
     */
    public final void stop() {
        if(null != runner) {
            runner.stop();
        }
    }

    /**
     * Create Moco Server.<br>
     * 
     * @param port server port
     * @param configFile configuration file
     * @return server created
     * @since SDNO 0.5
     */
    public abstract HttpServer createServer(int port);

    /**
     * Create Moco Server.<br>
     * 
     * @param port server port
     * @return server created
     * @since SDNO 0.5
     */
    public abstract HttpServer createServer();

    /**
     * Add Request and Response Pairs.<br>
     * 
     * @since SDNO 0.5
     */
    public void addRequestResponsePairs() throws ServiceException {
    }

    /**
     * Add Request and Response Pair.<br>
     * 
     * @param And matcher Request matcher
     * @param handler response handler
     * @throws ServiceException when failed
     * @since SDNO 0.5
     */
    protected final void addRequestResponsePair(RequestMatcher matchers, final ResponseHandler handler) {
        server.request(matchers).response(handler);
    }

    /**
     * Add Request and Response Pair.<br>
     * 
     * @param matchers Request Matcher
     * @param handler response handler
     * @param handlers list of response handler
     * @throws ServiceException when failed
     * @since SDNO 0.5
     */
    protected final void addRequestResponsePair(RequestMatcher matchers, final ResponseHandler handler,
            final ResponseHandler... handlers) {
        server.request(matchers).response(handler, handlers);
    }

    /**
     * Add Request and Response Pair.<br>
     * 
     * @param matchers Request Matcher
     * @param content response content
     * @throws ServiceException when failed
     * @since SDNO 0.5
     */
    protected final void addRequestResponsePair(RequestMatcher matchers, String content) {
        server.request(matchers).response(content);
    }

    /**
     * Add Request and Response Pair.<br>
     * 
     * @param configFile configuration file
     * @since SDNO 0.5
     */
    protected final void addRequestResponsePair(String configFile) {
        HttpRquestResponse httpObject = null;
        try {
            httpObject = HttpModelUtils.praseHttpRquestResponseFromFile(configFile);
        } catch(ServiceException e) {
            LOGGER.error("Read Json File failed!!", e);
            return;
        }

        MocoResponseHandler responseHandler = new MocoResponseHandler();
        responseHandler.setResponseObject(httpObject.getResponse());

        this.addRequestResponsePair(RequestMatcherUtils.createDefaultRequestMatcher(httpObject.getRequest()),
                responseHandler);
    }

    /**
     * Add Request and Response Pair.<br>
     * 
     * @param configFile configuration file
     * @param responseHandler response handler
     * @since SDNO 0.5
     */
    protected final void addRequestResponsePair(String configFile, MocoResponseHandler responseHandler) {
        HttpRquestResponse httpObject = null;
        try {
            httpObject = HttpModelUtils.praseHttpRquestResponseFromFile(configFile);
        } catch(ServiceException e) {
            LOGGER.error("Read Json File failed!!", e);
            return;
        }

        if(null != responseHandler) {
            responseHandler.setResponseObject(httpObject.getResponse());
        }

        this.addRequestResponsePair(RequestMatcherUtils.createDefaultRequestMatcher(httpObject.getRequest()),
                responseHandler);
    }

}
