/**
 * Licensed to Open-Ones Group under one or more contributor license
 * agreements. See the NOTICE file distributed with this work
 * for additional information regarding copyright ownership.
 * Open-Ones Group licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a
 * copy of the License at:
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package vn.com.mks.ca.gui;

import java.io.File;
import java.io.FileFilter;

import org.apache.log4j.Logger;

import rocky.common.CommonUtil;
import rocky.sizecounter.ISizeCounter;

/**
 * @author ThachLN
 *
 */
public class FileFilterImpl implements FileFilter {
    private final static Logger LOG = Logger.getLogger("FileFilterImpl");
    private ISizeCounter sizeCounter = null;
    /**
     * @param sizeCounter
     */
    public FileFilterImpl(ISizeCounter sizeCounter) {
        this.sizeCounter = sizeCounter;
    }

    /**
     * Accept only file is countable.
     * @param pathname
     * @return
     * @see java.io.FileFilter#accept(java.io.File)
     */
    @Override
    public boolean accept(File file) {
        boolean isCountable = false;
        if (file.isHidden()) {
            // Do nothing
        } else if (file.isDirectory()) {
            isCountable = true;
        } else if (file.isFile()) {
            String ext = CommonUtil.getExtension(file.getName());

            if (CommonUtil.isNNandNB(ext)) {
                isCountable = sizeCounter.isCountable(ext);
            }
        } else {
            // No statement
        }

        return isCountable;
    }

}
