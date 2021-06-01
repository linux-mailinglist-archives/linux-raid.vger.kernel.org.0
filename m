Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D630391A61
	for <lists+linux-raid@lfdr.de>; Wed, 26 May 2021 16:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhEZOi0 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 26 May 2021 10:38:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:35388 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234432AbhEZOi0 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 26 May 2021 10:38:26 -0400
IronPort-SDR: QM5MRTCEAxCuVUlCUlXW0iIFHXUAoz0AZGVj+qkjjMia1l7nGCA8qB3SinzkT7pUyF72TO60HA
 t+Y807R24fFw==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="200584075"
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="200584075"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 07:36:54 -0700
IronPort-SDR: BHgACycbe8lFyUomW78UWf1NKEAT1Fb1HJgePJ7E0YJvM7YlTkIN1TUNUOewqyxR1PUCAsV9nb
 pErwjUTZiX5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,331,1613462400"; 
   d="scan'208";a="414484197"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 26 May 2021 07:36:53 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1llueS-0002EM-6u; Wed, 26 May 2021 14:36:52 +0000
Date:   Wed, 26 May 2021 22:36:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org
Subject: [song-md:md-fixes] BUILD SUCCESS
 cc146267914950b12c2bdee68c1e9e5453c81cde
Message-ID: <60ae5cf8.a9mgLGIHWvo73Uo8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

tree/branch: git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-fixes
branch HEAD: cc146267914950b12c2bdee68c1e9e5453c81cde  md/raid5: remove an incorrect assert in in_chunk_boundary

elapsed time: 730m

configs tested: 190
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                     haps_hs_smp_defconfig
sh                           se7751_defconfig
arm                           sunxi_defconfig
openrisc                         alldefconfig
arm                       imx_v6_v7_defconfig
sh                          sdk7786_defconfig
sh                   rts7751r2dplus_defconfig
s390                          debug_defconfig
xtensa                    xip_kc705_defconfig
alpha                            allyesconfig
arm                       multi_v4t_defconfig
m68k                        m5272c3_defconfig
arm                        oxnas_v6_defconfig
powerpc                  mpc866_ads_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     tqm8548_defconfig
powerpc                      ppc44x_defconfig
sh                           se7780_defconfig
arm                        spear3xx_defconfig
powerpc                     tqm5200_defconfig
sh                            titan_defconfig
csky                                defconfig
mips                           ip22_defconfig
m68k                             allyesconfig
powerpc                     redwood_defconfig
mips                        omega2p_defconfig
arm                            xcep_defconfig
i386                                defconfig
powerpc                       eiger_defconfig
arm                         socfpga_defconfig
arm                          moxart_defconfig
powerpc                      katmai_defconfig
mips                         mpc30x_defconfig
mips                  cavium_octeon_defconfig
powerpc                      obs600_defconfig
mips                            ar7_defconfig
sh                           se7712_defconfig
arm                          iop32x_defconfig
arc                              alldefconfig
powerpc                    ge_imp3a_defconfig
um                               allmodconfig
powerpc                     pq2fads_defconfig
arm                         at91_dt_defconfig
powerpc                       holly_defconfig
sh                          rsk7269_defconfig
sh                         microdev_defconfig
powerpc                        fsp2_defconfig
arm                       netwinder_defconfig
sh                          sdk7780_defconfig
arm                          pxa168_defconfig
s390                                defconfig
sh                          lboxre2_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc832x_mds_defconfig
mips                    maltaup_xpa_defconfig
arm                         orion5x_defconfig
mips                           ip28_defconfig
mips                         db1xxx_defconfig
m68k                        mvme16x_defconfig
xtensa                         virt_defconfig
nios2                            alldefconfig
arm                      jornada720_defconfig
arm                            pleb_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                       spear13xx_defconfig
sh                           se7343_defconfig
sh                          rsk7264_defconfig
ia64                        generic_defconfig
sh                        dreamcast_defconfig
arm                         cm_x300_defconfig
mips                          rm200_defconfig
sparc64                             defconfig
arm                           omap1_defconfig
arm                       imx_v4_v5_defconfig
sh                          r7785rp_defconfig
powerpc                     asp8347_defconfig
um                             i386_defconfig
powerpc                      ppc64e_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                            qcom_defconfig
powerpc                      pasemi_defconfig
arm                            lart_defconfig
x86_64                            allnoconfig
m68k                          multi_defconfig
sh                           se7750_defconfig
arc                        vdk_hs38_defconfig
mips                      pic32mzda_defconfig
csky                             alldefconfig
sparc                       sparc32_defconfig
sh                           se7619_defconfig
sh                           se7206_defconfig
arm                       cns3420vb_defconfig
powerpc                     sequoia_defconfig
arc                          axs101_defconfig
sh                           se7724_defconfig
powerpc               mpc834x_itxgp_defconfig
nios2                            allyesconfig
parisc                generic-32bit_defconfig
arm                         lpc18xx_defconfig
mips                      fuloong2e_defconfig
sparc                       sparc64_defconfig
m68k                        stmark2_defconfig
alpha                            alldefconfig
arc                    vdk_hs38_smp_defconfig
m68k                        mvme147_defconfig
microblaze                      mmu_defconfig
arm                         nhk8815_defconfig
powerpc                 mpc8272_ads_defconfig
mips                          malta_defconfig
powerpc                         wii_defconfig
riscv                          rv32_defconfig
powerpc                      tqm8xx_defconfig
powerpc                   currituck_defconfig
mips                          ath25_defconfig
m68k                          hp300_defconfig
arm                       aspeed_g5_defconfig
arc                            hsdk_defconfig
mips                          rb532_defconfig
arm                        trizeps4_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210526
x86_64               randconfig-a001-20210526
x86_64               randconfig-a006-20210526
x86_64               randconfig-a003-20210526
x86_64               randconfig-a004-20210526
x86_64               randconfig-a002-20210526
i386                 randconfig-a001-20210526
i386                 randconfig-a002-20210526
i386                 randconfig-a005-20210526
i386                 randconfig-a004-20210526
i386                 randconfig-a003-20210526
i386                 randconfig-a006-20210526
i386                 randconfig-a011-20210526
i386                 randconfig-a016-20210526
i386                 randconfig-a015-20210526
i386                 randconfig-a012-20210526
i386                 randconfig-a014-20210526
i386                 randconfig-a013-20210526
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210526
x86_64               randconfig-a013-20210526
x86_64               randconfig-a012-20210526
x86_64               randconfig-a014-20210526
x86_64               randconfig-a016-20210526
x86_64               randconfig-a015-20210526
x86_64               randconfig-a011-20210526

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
