/*
 * Copyright (c) 2016, Huawei Technologies Co., Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.openo.sdno.overlayvpn.mocoserver;

import org.openo.sdno.testframework.moco.MocoHttpsServer;

public class ACBranchMocoServer extends MocoHttpsServer {

    private static final String QUERY_THINCPE_WAN_SUBINF =
            "src/integration-test/resources/AcBranchController/QueryThinCPEWanSubInf.json";

    private static final String QUERY_VCPE_SUBINF =
            "src/integration-test/resources/AcBranchController/QueryVCPEWanSubInf.json";

    private static final String SSO_LOGIN1 = "src/integration-test/resources/AcBranchController/SSOLogin1.json";

    private static final String SSO_LOGIN2 = "src/integration-test/resources/AcBranchController/SSOLogin2.json";

    private static final String CREATE_THINCPE_VXLAN =
            "src/integration-test/resources/AcBranchController/CreateThinCPEVxLan.json";

    private static final String CREATE_VCPE_VXLAN =
            "src/integration-test/resources/AcBranchController/CreatevCPEVxLan.json";

    private static final String DELETE_THINCPE_VXLAN =
            "src/integration-test/resources/AcBranchController/DeleteThinCPEVxLan.json";

    private static final String DELETE_VCPE_VXLAN =
            "src/integration-test/resources/AcBranchController/DeletevCPEVxLan.json";

    @Override
    public void addRequestResponsePairs() {
        this.addRequestResponsePair(QUERY_THINCPE_WAN_SUBINF);
        this.addRequestResponsePair(QUERY_VCPE_SUBINF);
        this.addRequestResponsePair(SSO_LOGIN1);
        this.addRequestResponsePair(SSO_LOGIN2);
        this.addRequestResponsePair(CREATE_THINCPE_VXLAN);
        this.addRequestResponsePair(CREATE_VCPE_VXLAN);
        this.addRequestResponsePair(DELETE_THINCPE_VXLAN);
        this.addRequestResponsePair(DELETE_VCPE_VXLAN);
    }

}
