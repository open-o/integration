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

package org.openo.sdno.testframework.replace;

import static org.junit.Assert.assertTrue;

import org.junit.Test;
import org.openo.baseservice.remoteservice.exception.ServiceException;

public class PathReplaceTest {

    @Test
    public void testReplaceUuid() {
        String key = "tempId";
        String urlModel = "/rest/svc/v1/{tempId}/ne";
        String uuid = "123456789";
        String urlResult = PathReplace.replaceUuid(key, urlModel, uuid);
        String realUrl = "/rest/svc/v1/123456789/ne";
        assertTrue(realUrl.equals(urlResult));
    }

    @Test
    public void testGetUuidFromUrlSuccess() throws ServiceException {
        String key = "tempId";
        String urlModel = "/rest/svc/v1/{tempId}/ne";
        String realUrl = "/rest/svc/v1/123456789/ne";
        String uuidResult = PathReplace.getUuidFromUrl(key, urlModel, realUrl);
        String realUuid = "123456789";
        assertTrue(realUuid.equals(uuidResult));
    }

    @Test
    public void testGetUuidFromUrlFailed() throws ServiceException {
        String key = "temId";
        String urlModel = "/rest/svc/v1/{tempId}/ne";
        String realUrl = "/rest/svc/v1/123456789/ne";
        String uuidResult = PathReplace.getUuidFromUrl(key, urlModel, realUrl);
        assertTrue(uuidResult == null);
    }
}
