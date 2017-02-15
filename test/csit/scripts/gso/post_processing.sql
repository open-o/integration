/*
 * Copyright 2017 Huawei Technologies Co., Ltd.
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
delete from inventory.t_lcm_defPackage_mapping where inventory.t_lcm_defPackage_mapping.serviceId in (select t_lcm_service.serviceId from gsodb.t_lcm_service);

delete from inventory.t_lcm_inputParam_mapping where inventory.t_lcm_inputParam_mapping.serviceId in (select t_lcm_service.serviceId from gsodb.t_lcm_service);

delete from inventory.t_lcm_servicebaseinfo where inventory.t_lcm_servicebaseinfo.serviceId in (select t_lcm_service.serviceId from gsodb.t_lcm_service);

delete from gsodb.t_lcm_service;

delete from gsodb.t_lcm_defPackage_mapping;

delete from gsodb.t_lcm_service_parameter;

delete from gsodb.t_lcm_svcsegment_operation;

delete from gsodb.t_lcm_service_operation;

delete from gsodb.t_lcm_service_segment;

commit;