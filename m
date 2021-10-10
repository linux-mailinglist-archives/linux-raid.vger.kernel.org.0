Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683FF427E00
	for <lists+linux-raid@lfdr.de>; Sun, 10 Oct 2021 00:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhJIW77 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 9 Oct 2021 18:59:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:5720 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhJIW77 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 9 Oct 2021 18:59:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="226649297"
X-IronPort-AV: E=Sophos;i="5.85,361,1624345200"; 
   d="scan'208";a="226649297"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 15:58:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,361,1624345200"; 
   d="scan'208";a="479370879"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Oct 2021 15:58:00 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mZLHz-0000fR-Np; Sat, 09 Oct 2021 22:57:59 +0000
Date:   Sun, 10 Oct 2021 06:57:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org
Subject: [song-md:md-next] BUILD SUCCESS
 2bb33192d6a707aa20f43ea865892b448dd298c1
Message-ID: <61621e6d.Yl42GEv+At5ybxtk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

tree/branch: git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
branch HEAD: 2bb33192d6a707aa20f43ea865892b448dd298c1  md: add sysfs entry for fail_fast flag in RAID1/RAID10

elapsed time: 1370m

configs tested: 223
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211009
powerpc              randconfig-c003-20211009
sh                          sdk7786_defconfig
arm                           stm32_defconfig
arm                             ezx_defconfig
arm                          exynos_defconfig
nios2                         10m50_defconfig
mips                       capcella_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    sam440ep_defconfig
powerpc                      tqm8xx_defconfig
sh                          rsk7269_defconfig
arm                             mxs_defconfig
m68k                        mvme147_defconfig
sh                            shmin_defconfig
powerpc                      pcm030_defconfig
um                             i386_defconfig
arm                            xcep_defconfig
arm                         lpc32xx_defconfig
mips                      maltaaprp_defconfig
arc                         haps_hs_defconfig
mips                    maltaup_xpa_defconfig
mips                          rb532_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                          iss_defconfig
arc                     haps_hs_smp_defconfig
arm                        mvebu_v5_defconfig
powerpc                       holly_defconfig
powerpc                    gamecube_defconfig
mips                       lemote2f_defconfig
sh                        sh7763rdp_defconfig
mips                        jmr3927_defconfig
mips                       rbtx49xx_defconfig
arm                           h5000_defconfig
m68k                        m5272c3_defconfig
arc                              allyesconfig
mips                        omega2p_defconfig
sh                        dreamcast_defconfig
mips                           gcw0_defconfig
powerpc                     pq2fads_defconfig
mips                         mpc30x_defconfig
m68k                          multi_defconfig
arm                       omap2plus_defconfig
ia64                                defconfig
powerpc                     tqm8548_defconfig
powerpc                  mpc885_ads_defconfig
arm                         at91_dt_defconfig
arm                       cns3420vb_defconfig
mips                          ath25_defconfig
xtensa                  cadence_csp_defconfig
arm                         axm55xx_defconfig
powerpc                     pseries_defconfig
xtensa                           alldefconfig
powerpc                     mpc83xx_defconfig
powerpc                          allyesconfig
sh                      rts7751r2d1_defconfig
m68k                          atari_defconfig
sh                   sh7770_generic_defconfig
arm                        mvebu_v7_defconfig
arm                       imx_v4_v5_defconfig
arm                          collie_defconfig
sh                           se7206_defconfig
sh                               allmodconfig
powerpc                 mpc837x_rdb_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                             alldefconfig
mips                           rs90_defconfig
mips                        bcm63xx_defconfig
mips                     loongson1b_defconfig
arm64                            alldefconfig
sh                             espt_defconfig
riscv                             allnoconfig
arm                          ixp4xx_defconfig
powerpc                      mgcoge_defconfig
mips                           mtx1_defconfig
sh                           se7712_defconfig
sh                   secureedge5410_defconfig
sh                            titan_defconfig
arm                        vexpress_defconfig
powerpc                      ppc40x_defconfig
um                                  defconfig
mips                           ip22_defconfig
mips                   sb1250_swarm_defconfig
arm                        realview_defconfig
arm                       versatile_defconfig
powerpc                 mpc836x_mds_defconfig
arm                          gemini_defconfig
m68k                            q40_defconfig
csky                                defconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                             allyesconfig
sh                               j2_defconfig
sh                           se7619_defconfig
sh                           se7721_defconfig
powerpc                      obs600_defconfig
arm                           sama7_defconfig
powerpc                     tqm8555_defconfig
arm                         s5pv210_defconfig
m68k                        m5307c3_defconfig
arm                   milbeaut_m10v_defconfig
arm                  colibri_pxa270_defconfig
arm                            mps2_defconfig
sh                          lboxre2_defconfig
mips                           xway_defconfig
arm                     eseries_pxa_defconfig
arm                          ep93xx_defconfig
x86_64               randconfig-c001-20211009
arm                  randconfig-c002-20211009
x86_64               randconfig-c001-20211008
i386                 randconfig-c001-20211008
arm                  randconfig-c002-20211008
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20211009
x86_64               randconfig-a005-20211009
x86_64               randconfig-a001-20211009
x86_64               randconfig-a002-20211009
x86_64               randconfig-a004-20211009
x86_64               randconfig-a006-20211009
i386                 randconfig-a001-20211009
i386                 randconfig-a003-20211009
i386                 randconfig-a005-20211009
i386                 randconfig-a004-20211009
i386                 randconfig-a002-20211009
i386                 randconfig-a006-20211009
x86_64               randconfig-a015-20211008
x86_64               randconfig-a012-20211008
x86_64               randconfig-a016-20211008
x86_64               randconfig-a013-20211008
x86_64               randconfig-a011-20211008
x86_64               randconfig-a014-20211008
i386                 randconfig-a013-20211008
i386                 randconfig-a016-20211008
i386                 randconfig-a014-20211008
i386                 randconfig-a011-20211008
i386                 randconfig-a012-20211008
i386                 randconfig-a015-20211008
arc                  randconfig-r043-20211008
s390                 randconfig-r044-20211008
riscv                randconfig-r042-20211008
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20211009
i386                 randconfig-c001-20211009
arm                  randconfig-c002-20211009
s390                 randconfig-c005-20211009
powerpc              randconfig-c003-20211009
riscv                randconfig-c006-20211009
mips                 randconfig-c004-20211009
arm                  randconfig-c002-20211010
mips                 randconfig-c004-20211010
i386                 randconfig-c001-20211010
s390                 randconfig-c005-20211010
x86_64               randconfig-c007-20211010
powerpc              randconfig-c003-20211010
riscv                randconfig-c006-20211010
i386                 randconfig-a001-20211008
i386                 randconfig-a003-20211008
i386                 randconfig-a005-20211008
i386                 randconfig-a004-20211008
i386                 randconfig-a002-20211008
i386                 randconfig-a006-20211008
x86_64               randconfig-a015-20211009
x86_64               randconfig-a012-20211009
x86_64               randconfig-a016-20211009
x86_64               randconfig-a013-20211009
x86_64               randconfig-a011-20211009
x86_64               randconfig-a014-20211009
i386                 randconfig-a013-20211009
i386                 randconfig-a016-20211009
i386                 randconfig-a014-20211009
i386                 randconfig-a012-20211009
i386                 randconfig-a011-20211009
i386                 randconfig-a015-20211009
x86_64               randconfig-a003-20211008
x86_64               randconfig-a005-20211008
x86_64               randconfig-a001-20211008
x86_64               randconfig-a002-20211008
x86_64               randconfig-a004-20211008
x86_64               randconfig-a006-20211008
hexagon              randconfig-r045-20211009
hexagon              randconfig-r041-20211009
s390                 randconfig-r044-20211009
riscv                randconfig-r042-20211009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
