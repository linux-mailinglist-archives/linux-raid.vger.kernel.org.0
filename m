Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9834223B137
	for <lists+linux-raid@lfdr.de>; Tue,  4 Aug 2020 01:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgHCXsE (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 3 Aug 2020 19:48:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:36476 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgHCXsD (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 3 Aug 2020 19:48:03 -0400
IronPort-SDR: eQWeNo9oNrvQQ61JWoS/6S8gBlMKNe0ZW2D0zmP/pEFYkGvVdrIBD7Au36/9ZzcWtzYchkpvQ5
 yBnJvh/vBSTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="139810128"
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="139810128"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 16:48:03 -0700
IronPort-SDR: Pd5WoUr7rGExgjMUUto7EJ31OT3da/GN9CfTCTHAJVQ7/aQtDtr5niB3LoBrnjuKreqnSG6TG4
 fhCn1gkAqlrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="315049712"
Received: from lkp-server02.sh.intel.com (HELO 84ccfe698a63) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2020 16:48:01 -0700
Received: from kbuild by 84ccfe698a63 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2kBV-0000Im-An; Mon, 03 Aug 2020 23:48:01 +0000
Date:   Tue, 04 Aug 2020 07:47:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org
Subject: [song-md:md-next] BUILD SUCCESS
 45a4d8fd6c7926e7991a1b29233d725fe12935da
Message-ID: <5f28a22a.5PlgrVBwvzy+OHTi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

tree/branch: git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git  md-next
branch HEAD: 45a4d8fd6c7926e7991a1b29233d725fe12935da  md/raid5: Allow degraded raid6 to do rmw

elapsed time: 725m

configs tested: 83
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                        generic_defconfig
m68k                       bvme6000_defconfig
arm                          pxa168_defconfig
arm                       aspeed_g4_defconfig
arc                          axs101_defconfig
powerpc                    amigaone_defconfig
sh                   sh7770_generic_defconfig
mips                        bcm47xx_defconfig
h8300                    h8300h-sim_defconfig
powerpc                          alldefconfig
mips                      bmips_stb_defconfig
arm                        magician_defconfig
h8300                       h8s-sim_defconfig
arm                        spear6xx_defconfig
mips                          rb532_defconfig
powerpc                     mpc83xx_defconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a004-20200803
i386                 randconfig-a005-20200803
i386                 randconfig-a001-20200803
i386                 randconfig-a002-20200803
i386                 randconfig-a003-20200803
i386                 randconfig-a006-20200803
x86_64               randconfig-a013-20200803
x86_64               randconfig-a011-20200803
x86_64               randconfig-a012-20200803
x86_64               randconfig-a016-20200803
x86_64               randconfig-a015-20200803
x86_64               randconfig-a014-20200803
i386                 randconfig-a011-20200803
i386                 randconfig-a012-20200803
i386                 randconfig-a015-20200803
i386                 randconfig-a014-20200803
i386                 randconfig-a013-20200803
i386                 randconfig-a016-20200803
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
