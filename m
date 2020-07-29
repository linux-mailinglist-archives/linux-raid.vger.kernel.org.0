Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B049823248D
	for <lists+linux-raid@lfdr.de>; Wed, 29 Jul 2020 20:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgG2SWu (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 29 Jul 2020 14:22:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:8425 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2SWu (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 29 Jul 2020 14:22:50 -0400
IronPort-SDR: goRHkygmqHrWq/FLktI1973m+9o0MHLn2h4iVXnb2wceqJDQfFjqJ6Gt/D3JueI810BcK4QhmI
 QVWjlqolNUoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="151457135"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="151457135"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 11:22:49 -0700
IronPort-SDR: nt592mPXAiZASIekN/DCMfkKvzYSjMTM05DDstR/tttNVESOvHhPWp53RKbRwyD1Ejv7hyFU8L
 Wvk3KSrxVDBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="313121566"
Received: from lkp-server02.sh.intel.com (HELO 1bde1f275adc) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jul 2020 11:22:48 -0700
Received: from kbuild by 1bde1f275adc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0qj1-0000Ad-UV; Wed, 29 Jul 2020 18:22:47 +0000
Date:   Thu, 30 Jul 2020 02:22:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Song Liu <song@kernel.org>
Cc:     linux-raid@vger.kernel.org
Subject: [song-md:md-next] BUILD SUCCESS
 4fdedbcc914e49851eb9f0ac7b8f2fe41407c935
Message-ID: <5f21be52.kpGhsO47D9ZHw6BV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

tree/branch: git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git  md-next
branch HEAD: 4fdedbcc914e49851eb9f0ac7b8f2fe41407c935  raid5: don't duplicate code for different paths in handle_stripe

elapsed time: 741m

configs tested: 48
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
