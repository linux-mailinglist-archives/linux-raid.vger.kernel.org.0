Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA08B228011
	for <lists+linux-raid@lfdr.de>; Tue, 21 Jul 2020 14:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgGUMgy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Jul 2020 08:36:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:54081 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgGUMgx (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 21 Jul 2020 08:36:53 -0400
IronPort-SDR: opuNZ7bfr0bcVNew1gTA98gW1nGiTlWY3Qy3pGVCjvabeSk/HLW7XGDpVCNr3uhuHFkI7pi7Fq
 0vrOCjfJ+1TA==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="130187333"
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="130187333"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 05:36:51 -0700
IronPort-SDR: iHLArFkIHlQaefqDdV3DwvQ6spZKNvq8/Y5x8p7Qeu75Q63n8D95+3ZWJsoMGbmXXFM5QE/MEk
 Bcf/6SF8yndA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="362349228"
Received: from lkp-server02.sh.intel.com (HELO 7dd7ac9fbea4) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2020 05:36:50 -0700
Received: from kbuild by 7dd7ac9fbea4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jxrVp-000061-Ix; Tue, 21 Jul 2020 12:36:49 +0000
Date:   Tue, 21 Jul 2020 20:35:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org
Subject: [song-md:md-next] BUILD SUCCESS
 1684e97538b9484c72bcaff2961569c3b0021473
Message-ID: <5f16e122.9DKLcRHs8GuVPwi0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

tree/branch: git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git  md-next
branch HEAD: 1684e97538b9484c72bcaff2961569c3b0021473  raid5: remove the meaningless check in raid5_make_request

elapsed time: 6862m

configs tested: 104
configs skipped: 1

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
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
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
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
x86_64               randconfig-a005-20200717
x86_64               randconfig-a006-20200717
x86_64               randconfig-a002-20200717
x86_64               randconfig-a001-20200717
x86_64               randconfig-a003-20200717
x86_64               randconfig-a004-20200717
i386                 randconfig-a001-20200716
i386                 randconfig-a005-20200716
i386                 randconfig-a002-20200716
i386                 randconfig-a006-20200716
i386                 randconfig-a003-20200716
i386                 randconfig-a004-20200716
x86_64               randconfig-a012-20200716
x86_64               randconfig-a011-20200716
x86_64               randconfig-a016-20200716
x86_64               randconfig-a014-20200716
x86_64               randconfig-a013-20200716
x86_64               randconfig-a015-20200716
i386                 randconfig-a016-20200716
i386                 randconfig-a011-20200716
i386                 randconfig-a015-20200716
i386                 randconfig-a012-20200716
i386                 randconfig-a013-20200716
i386                 randconfig-a014-20200716
i386                 randconfig-a015-20200719
i386                 randconfig-a011-20200719
i386                 randconfig-a016-20200719
i386                 randconfig-a012-20200719
i386                 randconfig-a013-20200719
i386                 randconfig-a014-20200719
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
