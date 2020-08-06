Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7508E23DFB7
	for <lists+linux-raid@lfdr.de>; Thu,  6 Aug 2020 19:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgHFRwa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 Aug 2020 13:52:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:45067 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728445AbgHFQbi (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 6 Aug 2020 12:31:38 -0400
IronPort-SDR: KgYlHhBC3OYMtqJiMF7VyeCCWsGQkbS8lGyGDTOt04CRfFL2az4Nz8BDIa94XJCtKZZ3il/EUq
 eF96KjhXV1Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="152750120"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="152750120"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 06:05:13 -0700
IronPort-SDR: CLvAUn4C1RPBspqXmafnqD6IhZ3t/8PB8SzWW3OZrPCuG3JQefiekQv+TNWKOyTUA+hxysOqF3
 qDlsfERkTPTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="493658298"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2020 06:05:12 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3fa3-0001J7-GO; Thu, 06 Aug 2020 13:05:11 +0000
Date:   Thu, 06 Aug 2020 21:05:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org
Subject: [song-md:md-next] BUILD SUCCESS
 e8abe1de43dac658dacbd04a4543e0c988a8d386
Message-ID: <5f2bfffd.8d431al4anPNjBI2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

tree/branch: git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git  md-next
branch HEAD: e8abe1de43dac658dacbd04a4543e0c988a8d386  md-cluster: Fix potential error pointer dereference in resize_bitmaps()

elapsed time: 721m

configs tested: 109
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          polaris_defconfig
mips                  mips_paravirt_defconfig
microblaze                      mmu_defconfig
powerpc64                           defconfig
powerpc                      mgcoge_defconfig
sh                   sh7770_generic_defconfig
powerpc64                        alldefconfig
mips                      maltasmvp_defconfig
mips                         tb0287_defconfig
sh                        dreamcast_defconfig
mips                      fuloong2e_defconfig
mips                     loongson1c_defconfig
arm                          lpd270_defconfig
powerpc                    amigaone_defconfig
powerpc                      pasemi_defconfig
arm                             rpc_defconfig
m68k                        mvme147_defconfig
m68k                          multi_defconfig
powerpc                      chrp32_defconfig
mips                        omega2p_defconfig
arm                            xcep_defconfig
sh                   rts7751r2dplus_defconfig
arc                        vdk_hs38_defconfig
arm                      tct_hammer_defconfig
mips                     loongson1b_defconfig
arm                             ezx_defconfig
s390                          debug_defconfig
sh                           se7722_defconfig
ia64                            zx1_defconfig
mips                 decstation_r4k_defconfig
openrisc                    or1ksim_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200806
x86_64               randconfig-a001-20200806
x86_64               randconfig-a004-20200806
x86_64               randconfig-a005-20200806
x86_64               randconfig-a003-20200806
x86_64               randconfig-a002-20200806
i386                 randconfig-a005-20200805
i386                 randconfig-a004-20200805
i386                 randconfig-a001-20200805
i386                 randconfig-a003-20200805
i386                 randconfig-a002-20200805
i386                 randconfig-a006-20200805
i386                 randconfig-a005-20200806
i386                 randconfig-a004-20200806
i386                 randconfig-a001-20200806
i386                 randconfig-a002-20200806
i386                 randconfig-a003-20200806
i386                 randconfig-a006-20200806
x86_64               randconfig-a013-20200805
x86_64               randconfig-a011-20200805
x86_64               randconfig-a012-20200805
x86_64               randconfig-a016-20200805
x86_64               randconfig-a015-20200805
x86_64               randconfig-a014-20200805
i386                 randconfig-a011-20200805
i386                 randconfig-a012-20200805
i386                 randconfig-a013-20200805
i386                 randconfig-a014-20200805
i386                 randconfig-a015-20200805
i386                 randconfig-a016-20200805
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
