Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD70F42DF50
	for <lists+linux-raid@lfdr.de>; Thu, 14 Oct 2021 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhJNQnm (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 14 Oct 2021 12:43:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:38900 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231839AbhJNQnl (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 14 Oct 2021 12:43:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="227619040"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="227619040"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 09:41:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="scan'208";a="525124717"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Oct 2021 09:41:34 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mb3nR-0006OI-ET; Thu, 14 Oct 2021 16:41:33 +0000
Date:   Fri, 15 Oct 2021 00:41:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org
Subject: [song-md:md-next] BUILD SUCCESS
 773b8643feab20df1f857b7096b1eafc261020d8
Message-ID: <61685dbb.vpnEbmWZ1wIa/AVW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

tree/branch: git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
branch HEAD: 773b8643feab20df1f857b7096b1eafc261020d8  md: update superblock after changing rdev flags in state_store

elapsed time: 1406m

configs tested: 224
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211013
i386                 randconfig-c001-20211014
sh                         microdev_defconfig
powerpc                   lite5200b_defconfig
powerpc                      cm5200_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     akebono_defconfig
mips                         tb0226_defconfig
mips                        nlm_xlr_defconfig
sh                             shx3_defconfig
sh                           se7705_defconfig
powerpc                      chrp32_defconfig
mips                      pic32mzda_defconfig
arm                         orion5x_defconfig
arm                  colibri_pxa300_defconfig
powerpc                       maple_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                              ul2_defconfig
arm                       aspeed_g5_defconfig
sh                          sdk7786_defconfig
sparc                            alldefconfig
ia64                         bigsur_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                   sh7724_generic_defconfig
arm                           spitz_defconfig
arm                       multi_v4t_defconfig
xtensa                           alldefconfig
arm                       omap2plus_defconfig
mips                        bcm47xx_defconfig
arm                        multi_v5_defconfig
arm                      jornada720_defconfig
powerpc                     mpc5200_defconfig
arm                          iop32x_defconfig
powerpc                      ppc40x_defconfig
ia64                      gensparse_defconfig
arm                        shmobile_defconfig
powerpc                      mgcoge_defconfig
arm                        spear6xx_defconfig
mips                          ath79_defconfig
arm                      integrator_defconfig
xtensa                    xip_kc705_defconfig
mips                      maltaaprp_defconfig
arm                     eseries_pxa_defconfig
arc                      axs103_smp_defconfig
arm                        mvebu_v7_defconfig
sh                     magicpanelr2_defconfig
arm                         nhk8815_defconfig
powerpc                         ps3_defconfig
powerpc                 mpc8560_ads_defconfig
um                             i386_defconfig
csky                                defconfig
arm                        vexpress_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                          amiga_defconfig
mips                           xway_defconfig
m68k                         amcore_defconfig
arm                        mini2440_defconfig
mips                         tb0287_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
xtensa                    smp_lx200_defconfig
m68k                           sun3_defconfig
parisc                generic-32bit_defconfig
powerpc                       eiger_defconfig
mips                            e55_defconfig
ia64                             alldefconfig
arm                       aspeed_g4_defconfig
mips                        omega2p_defconfig
powerpc                 mpc836x_mds_defconfig
arc                        vdk_hs38_defconfig
powerpc                 mpc8272_ads_defconfig
arm64                            alldefconfig
sh                        sh7757lcr_defconfig
arm                         shannon_defconfig
powerpc                   currituck_defconfig
arm                         s3c6400_defconfig
powerpc                    klondike_defconfig
arm                        magician_defconfig
mips                           ip32_defconfig
powerpc                    amigaone_defconfig
parisc                              defconfig
powerpc                      arches_defconfig
sparc                       sparc32_defconfig
m68k                             alldefconfig
nds32                               defconfig
mips                         tb0219_defconfig
sh                          urquell_defconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                         lpc18xx_defconfig
sh                          landisk_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                       m5475evb_defconfig
m68k                        mvme147_defconfig
powerpc                      ppc64e_defconfig
powerpc                 canyonlands_defconfig
mips                        bcm63xx_defconfig
sh                           se7780_defconfig
sh                             sh03_defconfig
powerpc                     ep8248e_defconfig
m68k                       m5249evb_defconfig
m68k                        m5307c3_defconfig
m68k                       m5208evb_defconfig
powerpc                    gamecube_defconfig
arm                          ixp4xx_defconfig
powerpc                     stx_gp3_defconfig
powerpc                   motionpro_defconfig
arm                          pcm027_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                  randconfig-c002-20211014
x86_64               randconfig-c001-20211014
arm                  randconfig-c002-20211013
x86_64               randconfig-c001-20211013
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211014
x86_64               randconfig-a004-20211014
x86_64               randconfig-a001-20211014
x86_64               randconfig-a005-20211014
x86_64               randconfig-a002-20211014
x86_64               randconfig-a003-20211014
i386                 randconfig-a003-20211014
i386                 randconfig-a001-20211014
i386                 randconfig-a005-20211014
i386                 randconfig-a004-20211014
i386                 randconfig-a002-20211014
i386                 randconfig-a006-20211014
x86_64               randconfig-a015-20211013
x86_64               randconfig-a012-20211013
x86_64               randconfig-a016-20211013
x86_64               randconfig-a014-20211013
x86_64               randconfig-a013-20211013
x86_64               randconfig-a011-20211013
i386                 randconfig-a016-20211013
i386                 randconfig-a014-20211013
i386                 randconfig-a011-20211013
i386                 randconfig-a015-20211013
i386                 randconfig-a012-20211013
i386                 randconfig-a013-20211013
arc                  randconfig-r043-20211013
s390                 randconfig-r044-20211013
riscv                randconfig-r042-20211013
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
arm                  randconfig-c002-20211014
i386                 randconfig-c001-20211014
s390                 randconfig-c005-20211014
x86_64               randconfig-c007-20211014
powerpc              randconfig-c003-20211014
riscv                randconfig-c006-20211014
x86_64               randconfig-a004-20211013
x86_64               randconfig-a006-20211013
x86_64               randconfig-a001-20211013
x86_64               randconfig-a005-20211013
x86_64               randconfig-a002-20211013
x86_64               randconfig-a003-20211013
i386                 randconfig-a001-20211013
i386                 randconfig-a003-20211013
i386                 randconfig-a004-20211013
i386                 randconfig-a005-20211013
i386                 randconfig-a002-20211013
i386                 randconfig-a006-20211013
x86_64               randconfig-a012-20211014
x86_64               randconfig-a015-20211014
x86_64               randconfig-a016-20211014
x86_64               randconfig-a014-20211014
x86_64               randconfig-a011-20211014
x86_64               randconfig-a013-20211014
i386                 randconfig-a016-20211014
i386                 randconfig-a014-20211014
i386                 randconfig-a011-20211014
i386                 randconfig-a015-20211014
i386                 randconfig-a012-20211014
i386                 randconfig-a013-20211014
hexagon              randconfig-r041-20211013
hexagon              randconfig-r045-20211013
hexagon              randconfig-r041-20211014
s390                 randconfig-r044-20211014
riscv                randconfig-r042-20211014
hexagon              randconfig-r045-20211014

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
