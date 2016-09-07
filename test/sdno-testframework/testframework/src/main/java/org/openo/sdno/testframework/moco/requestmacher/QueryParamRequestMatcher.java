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

package org.openo.sdno.testframework.moco.requestmacher;

import java.util.Map;
import java.util.regex.Pattern;

import org.openo.sdno.testframework.http.model.HttpRequest;

import com.github.dreamhead.moco.MocoConfig;
import com.github.dreamhead.moco.Request;
import com.github.dreamhead.moco.RequestMatcher;
import com.github.dreamhead.moco.model.DefaultHttpRequest;
import com.google.common.collect.ImmutableMap;

/**
 * RequestMatcher for Query Parameter.<br>
 * 
 * @author
 * @version SDNO 0.5 Aug 16, 2016
 */
public class QueryParamRequestMatcher implements RequestMatcher {

    private HttpRequest matchedRequest;

    /**
     * Constructor<br>
     * 
     * @param matchedRequest Match request matcher
     * @since SDNO 0.5
     */
    public QueryParamRequestMatcher(HttpRequest matchedRequest) {
        this.matchedRequest = matchedRequest;
    }

    @Override
    public RequestMatcher apply(MocoConfig config) {
        return null;
    }

    @Override
    public boolean match(Request request) {

        DefaultHttpRequest inHttpRequest = (DefaultHttpRequest)request;
        Map<String, String> matchedQueryMap = matchedRequest.getQueries();
        if(null == matchedQueryMap || matchedQueryMap.isEmpty()) {
            return true;
        }

        ImmutableMap<String, String[]> inQueryMap = inHttpRequest.getQueries();

        for(Map.Entry<String, String> curQueryEntity : matchedQueryMap.entrySet()) {

            String[] curInParamList = inQueryMap.get(curQueryEntity.getKey());

            // impossible matches
            if(null == curInParamList || 0 == curInParamList.length) {
                return false;
            }

            if(!Pattern.compile(curQueryEntity.getValue()).matcher(curInParamList[0]).matches()) {
                return false;
            }
        }

        return true;
    }

}
