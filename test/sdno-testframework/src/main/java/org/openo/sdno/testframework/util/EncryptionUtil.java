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

package org.openo.sdno.testframework.util;

import org.openo.baseservice.encrypt.cbb.CipherCreator;
import org.openo.baseservice.encrypt.cbb.inf.AbstractCipher;

/**
 * Encapsulation of encryption method of the platform. <br>
 * 
 * @author
 * @version SDNO 0.5 2016-4-13
 */
public class EncryptionUtil {

    private EncryptionUtil() {

    }

    /**
     * encryption method. <br>
     * 
     * @param plain char array represent the String need to encrypted.
     * @return char array of the encrypted string.
     * @throws CipherException if internal error happens.
     * @since SDNO 0.5
     */
    public static char[] encode(char[] plain) {
        AbstractCipher abstractCipher = CipherCreator.instance().create();
        return abstractCipher.encrypt(String.valueOf(plain)).toCharArray();
    }

    /**
     * decipher method. <br>
     * 
     * @param plain char array need to be deciphered.
     * @return char array of the deciphered string
     * @throws CipherException if internal error happens.
     * @since SDNO 0.5
     */
    public static char[] decode(char[] plain) {
        AbstractCipher abstractCipher = CipherCreator.instance().create();
        return abstractCipher.decrypt(String.valueOf(plain)).toCharArray();
    }

    /**
     * Clear the encrypted char array. <br>
     * 
     * @param plain char array to be cleared.
     * @since SDNO 0.5
     */
    public static void clear(char[] plain) {
        if((plain != null) && (plain.length > 0)) {
            for(int i = 0, len = plain.length; i < len; i++) {
                plain[i] = '\0';
            }
        }
    }
}
