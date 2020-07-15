Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A6E221728
	for <lists+linux-raid@lfdr.de>; Wed, 15 Jul 2020 23:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgGOVlB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 15 Jul 2020 17:41:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:12063 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgGOVlB (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 15 Jul 2020 17:41:01 -0400
IronPort-SDR: JTpRd5KIYl8cxOFuzxFaAQ7bk1el3sLWPf83AdONxR49DwEpQnxGosnu1lnTqm2DlEkW1TJn1J
 y0vEhBJI/Fdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="136726102"
X-IronPort-AV: E=Sophos;i="5.75,356,1589266800"; 
   d="scan'208";a="136726102"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 14:41:00 -0700
IronPort-SDR: sHn1jDRa20CnWmBZIyfd8HlW9emOcJn4avjPMecZPUIfAaz9meSRLT7p/S6XIuc3v+uvFLFGHw
 klSgGNmYBIIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,356,1589266800"; 
   d="scan'208";a="282235840"
Received: from lkp-server01.sh.intel.com (HELO e5b4d2dd85a6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2020 14:40:59 -0700
Received: from kbuild by e5b4d2dd85a6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jvp98-00008g-UB; Wed, 15 Jul 2020 21:40:58 +0000
Date:   Thu, 16 Jul 2020 05:40:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org
Subject: [song-md:md-next] BUILD SUCCESS
 60f80d6f2d07a6d8aee485a1d1252327eeee0c81
Message-ID: <5f0f77e0.h7ynUsUdIDekmd4u%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

tree/branch: git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git  md-next
branch HEAD: 60f80d6f2d07a6d8aee485a1d1252327eeee0c81  md-cluster: fix wild pointer of unlock_all_bitmaps()

elapsed time: 726m

configs tested: 99
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arc                          axs101_defconfig
c6x                        evmc6457_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                    gamecube_defconfig
arm                          lpd270_defconfig
arm                        spear6xx_defconfig
mips                       rbtx49xx_defconfig
arm                      integrator_defconfig
mips                           ci20_defconfig
sh                          lboxre2_defconfig
i386                             allyesconfig
mips                          malta_defconfig
riscv                               defconfig
c6x                        evmc6474_defconfig
sparc                            alldefconfig
mips                       capcella_defconfig
mips                        nlm_xlr_defconfig
powerpc                      pmac32_defconfig
arm                        clps711x_defconfig
arm                           corgi_defconfig
riscv                            allyesconfig
arm                         orion5x_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a016-20200715
i386                 randconfig-a011-20200715
i386                 randconfig-a015-20200715
i386                 randconfig-a012-20200715
i386                 randconfig-a013-20200715
i386                 randconfig-a014-20200715
riscv                             allnoconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
