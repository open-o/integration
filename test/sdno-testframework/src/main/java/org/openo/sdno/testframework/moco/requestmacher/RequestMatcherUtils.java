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

import static com.github.dreamhead.moco.Moco.by;
import static com.github.dreamhead.moco.Moco.match;
import static com.github.dreamhead.moco.Moco.method;
import static com.github.dreamhead.moco.Moco.uri;

import java.util.ArrayList;
import java.util.List;

import org.openo.sdno.testframework.http.model.HttpRequest;

import com.github.dreamhead.moco.RequestMatcher;
import com.github.dreamhead.moco.matcher.AndRequestMatcher;

/**
 * Util class of RequestMatcher.<br>
 * 
 * @author
 * @version SDNO 0.5 Jun 25, 2016
 */
public class RequestMatcherUtils {

    private RequestMatcherUtils() {

    }

    /**
     * Create default Request Matcher.<br>
     * 
     * @param request MocoRequest Object
     * @return request matcher
     * @since SDNO 0.5
     */
    public static RequestMatcher createDefaultRequestMatcher(HttpRequest request) {

        RequestMatcher uriMatcher = match(uri(request.getUri()));
        RequestMatcher methodMatcher = by(method(request.getMethod()));
        RequestMatcher queryMatcher = new QueryParamRequestMatcher(request);

        List<RequestMatcher> matcherList = new ArrayList<RequestMatcher>();
        matcherList.add(uriMatcher);
        matcherList.add(methodMatcher);
        matcherList.add(queryMatcher);
        return new AndRequestMatcher(matcherList);
    }
}
