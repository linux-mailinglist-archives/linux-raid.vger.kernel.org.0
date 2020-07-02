Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B218921274B
	for <lists+linux-raid@lfdr.de>; Thu,  2 Jul 2020 17:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgGBPFp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 2 Jul 2020 11:05:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:51214 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729606AbgGBPFp (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 2 Jul 2020 11:05:45 -0400
IronPort-SDR: 4Xt0Bz2F0x/mKZYcCNGCjHmr4rh3UhNT326+48chibzvPHbDhPHA8oof1l06RGXKFgBXbVLUw5
 7Cf3VPfmxQuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="145058279"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="gz'50?scan'50,208,50";a="145058279"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 07:52:35 -0700
IronPort-SDR: P+IbuUddkKXb0IY/9w93JgeKq6A5KkjFq1jJJ/amfwqUaInSkGQksJpdLtxJglHoKCulhFiKDp
 Hh8rGE7Gr4ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="gz'50?scan'50,208,50";a="314153512"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 Jul 2020 07:52:32 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jr0Zk-0003i3-3B; Thu, 02 Jul 2020 14:52:32 +0000
Date:   Thu, 2 Jul 2020 22:51:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yufen Yu <yuyufen@huawei.com>, song@kernel.org
Cc:     kbuild-all@lists.01.org, linux-raid@vger.kernel.org,
        neilb@suse.com, guoqing.jiang@cloud.ionos.com, houtao1@huawei.com,
        yuyufen@huawei.com
Subject: Re: [PATCH v5 01/16] md/raid456: covert macro define of STRIPE_* as
 members of struct r5conf
Message-ID: <202007022231.B5BLGQQW%lkp@intel.com>
References: <20200702120628.777303-2-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20200702120628.777303-2-yuyufen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yufen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on song-md/md-next]
[also build test WARNING on cryptodev/master v5.8-rc3 next-20200702]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Yufen-Yu/md-raid5-set-STRIPE_SIZE-as-a-configurable-value/20200702-200949
base:   git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
config: parisc-defconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:15,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/blkdev.h:5,
                    from drivers/md/raid5.c:38:
   drivers/md/raid5.c: In function 'raid5_end_read_request':
   include/linux/kern_levels.h:5:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'unsigned int' [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/printk.h:507:10: note: in definition of macro 'printk_ratelimited'
     507 |   printk(fmt, ##__VA_ARGS__);    \
         |          ^~~
   include/linux/kern_levels.h:14:19: note: in expansion of macro 'KERN_SOH'
      14 | #define KERN_INFO KERN_SOH "6" /* informational */
         |                   ^~~~~~~~
   include/linux/printk.h:527:21: note: in expansion of macro 'KERN_INFO'
     527 |  printk_ratelimited(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
         |                     ^~~~~~~~~
>> drivers/md/raid5.c:2533:4: note: in expansion of macro 'pr_info_ratelimited'
    2533 |    pr_info_ratelimited(
         |    ^~~~~~~~~~~~~~~~~~~
   drivers/md/raid5.c:2534:42: note: format string is defined here
    2534 |     "md/raid:%s: read error corrected (%lu sectors at %llu on %s)\n",
         |                                        ~~^
         |                                          |
         |                                          long unsigned int
         |                                        %u
   In file included from include/linux/printk.h:7,
                    from include/linux/kernel.h:15,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/blkdev.h:5,
                    from drivers/md/raid5.c:38:
   drivers/md/raid5.c: In function 'check_stripe_cache':
   include/linux/kern_levels.h:5:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'unsigned int' [-Wformat=]
       5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
         |                  ^~~~~~
   include/linux/kern_levels.h:12:22: note: in expansion of macro 'KERN_SOH'
      12 | #define KERN_WARNING KERN_SOH "4" /* warning conditions */
         |                      ^~~~~~~~
   include/linux/printk.h:348:9: note: in expansion of macro 'KERN_WARNING'
     348 |  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~
>> drivers/md/raid5.c:7853:3: note: in expansion of macro 'pr_warn'
    7853 |   pr_warn("md/raid:%s: reshape: not enough stripes.  Needed %lu\n",
         |   ^~~~~~~
   drivers/md/raid5.c:7853:63: note: format string is defined here
    7853 |   pr_warn("md/raid:%s: reshape: not enough stripes.  Needed %lu\n",
         |                                                             ~~^
         |                                                               |
         |                                                               long unsigned int
         |                                                             %u
   drivers/md/raid5.c: In function 'raid5_start_reshape':
   drivers/md/raid5.c:7993:31: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    7993 |       /* Failure here is OK */;
         |                               ^

vim +/pr_info_ratelimited +2533 drivers/md/raid5.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  2490  
4246a0b63bd8f5 Christoph Hellwig 2015-07-20  2491  static void raid5_end_read_request(struct bio * bi)
^1da177e4c3f41 Linus Torvalds    2005-04-16  2492  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  2493  	struct stripe_head *sh = bi->bi_private;
d1688a6d5515f1 NeilBrown         2011-10-11  2494  	struct r5conf *conf = sh->raid_conf;
7ecaa1e6a1ad69 NeilBrown         2006-03-27  2495  	int disks = sh->disks, i;
d69504325978c4 NeilBrown         2006-07-10  2496  	char b[BDEVNAME_SIZE];
dd054fce88d33d NeilBrown         2011-12-23  2497  	struct md_rdev *rdev = NULL;
05616be5e11f66 NeilBrown         2012-05-21  2498  	sector_t s;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2499  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2500  	for (i=0 ; i<disks; i++)
^1da177e4c3f41 Linus Torvalds    2005-04-16  2501  		if (bi == &sh->dev[i].req)
^1da177e4c3f41 Linus Torvalds    2005-04-16  2502  			break;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2503  
4246a0b63bd8f5 Christoph Hellwig 2015-07-20  2504  	pr_debug("end_read_request %llu/%d, count: %d, error %d.\n",
^1da177e4c3f41 Linus Torvalds    2005-04-16  2505  		(unsigned long long)sh->sector, i, atomic_read(&sh->count),
4e4cbee93d5613 Christoph Hellwig 2017-06-03  2506  		bi->bi_status);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2507  	if (i == disks) {
5f9d1fde7d54a5 Shaohua Li        2016-08-22  2508  		bio_reset(bi);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2509  		BUG();
6712ecf8f64811 NeilBrown         2007-09-27  2510  		return;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2511  	}
14a75d3e07c784 NeilBrown         2011-12-23  2512  	if (test_bit(R5_ReadRepl, &sh->dev[i].flags))
dd054fce88d33d NeilBrown         2011-12-23  2513  		/* If replacement finished while this request was outstanding,
dd054fce88d33d NeilBrown         2011-12-23  2514  		 * 'replacement' might be NULL already.
dd054fce88d33d NeilBrown         2011-12-23  2515  		 * In that case it moved down to 'rdev'.
dd054fce88d33d NeilBrown         2011-12-23  2516  		 * rdev is not removed until all requests are finished.
dd054fce88d33d NeilBrown         2011-12-23  2517  		 */
14a75d3e07c784 NeilBrown         2011-12-23  2518  		rdev = conf->disks[i].replacement;
dd054fce88d33d NeilBrown         2011-12-23  2519  	if (!rdev)
14a75d3e07c784 NeilBrown         2011-12-23  2520  		rdev = conf->disks[i].rdev;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2521  
05616be5e11f66 NeilBrown         2012-05-21  2522  	if (use_new_offset(conf, sh))
05616be5e11f66 NeilBrown         2012-05-21  2523  		s = sh->sector + rdev->new_data_offset;
05616be5e11f66 NeilBrown         2012-05-21  2524  	else
05616be5e11f66 NeilBrown         2012-05-21  2525  		s = sh->sector + rdev->data_offset;
4e4cbee93d5613 Christoph Hellwig 2017-06-03  2526  	if (!bi->bi_status) {
^1da177e4c3f41 Linus Torvalds    2005-04-16  2527  		set_bit(R5_UPTODATE, &sh->dev[i].flags);
4e5314b56a7ea1 NeilBrown         2005-11-08  2528  		if (test_bit(R5_ReadError, &sh->dev[i].flags)) {
14a75d3e07c784 NeilBrown         2011-12-23  2529  			/* Note that this cannot happen on a
14a75d3e07c784 NeilBrown         2011-12-23  2530  			 * replacement device.  We just fail those on
14a75d3e07c784 NeilBrown         2011-12-23  2531  			 * any error
14a75d3e07c784 NeilBrown         2011-12-23  2532  			 */
cc6167b4f3b3ca NeilBrown         2016-11-02 @2533  			pr_info_ratelimited(
cc6167b4f3b3ca NeilBrown         2016-11-02  2534  				"md/raid:%s: read error corrected (%lu sectors at %llu on %s)\n",
98afa1940ade70 Yufen Yu          2020-07-02  2535  				mdname(conf->mddev),
98afa1940ade70 Yufen Yu          2020-07-02  2536  				conf->stripe_sectors,
05616be5e11f66 NeilBrown         2012-05-21  2537  				(unsigned long long)s,
d69504325978c4 NeilBrown         2006-07-10  2538  				bdevname(rdev->bdev, b));
98afa1940ade70 Yufen Yu          2020-07-02  2539  			atomic_add(conf->stripe_sectors, &rdev->corrected_errors);
4e5314b56a7ea1 NeilBrown         2005-11-08  2540  			clear_bit(R5_ReadError, &sh->dev[i].flags);
4e5314b56a7ea1 NeilBrown         2005-11-08  2541  			clear_bit(R5_ReWrite, &sh->dev[i].flags);
3f9e7c140e4c4e majianpeng        2012-07-31  2542  		} else if (test_bit(R5_ReadNoMerge, &sh->dev[i].flags))
3f9e7c140e4c4e majianpeng        2012-07-31  2543  			clear_bit(R5_ReadNoMerge, &sh->dev[i].flags);
3f9e7c140e4c4e majianpeng        2012-07-31  2544  
86aa1397ddfde5 Song Liu          2017-01-12  2545  		if (test_bit(R5_InJournal, &sh->dev[i].flags))
86aa1397ddfde5 Song Liu          2017-01-12  2546  			/*
86aa1397ddfde5 Song Liu          2017-01-12  2547  			 * end read for a page in journal, this
86aa1397ddfde5 Song Liu          2017-01-12  2548  			 * must be preparing for prexor in rmw
86aa1397ddfde5 Song Liu          2017-01-12  2549  			 */
86aa1397ddfde5 Song Liu          2017-01-12  2550  			set_bit(R5_OrigPageUPTDODATE, &sh->dev[i].flags);
86aa1397ddfde5 Song Liu          2017-01-12  2551  
14a75d3e07c784 NeilBrown         2011-12-23  2552  		if (atomic_read(&rdev->read_errors))
14a75d3e07c784 NeilBrown         2011-12-23  2553  			atomic_set(&rdev->read_errors, 0);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2554  	} else {
14a75d3e07c784 NeilBrown         2011-12-23  2555  		const char *bdn = bdevname(rdev->bdev, b);
ba22dcbf106338 NeilBrown         2005-11-08  2556  		int retry = 0;
2e8ac30312973d majianpeng        2012-07-03  2557  		int set_bad = 0;
d69504325978c4 NeilBrown         2006-07-10  2558  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2559  		clear_bit(R5_UPTODATE, &sh->dev[i].flags);
b76b4715eba0d0 Nigel Croxon      2019-09-06  2560  		if (!(bi->bi_status == BLK_STS_PROTECTION))
d69504325978c4 NeilBrown         2006-07-10  2561  			atomic_inc(&rdev->read_errors);
14a75d3e07c784 NeilBrown         2011-12-23  2562  		if (test_bit(R5_ReadRepl, &sh->dev[i].flags))
cc6167b4f3b3ca NeilBrown         2016-11-02  2563  			pr_warn_ratelimited(
cc6167b4f3b3ca NeilBrown         2016-11-02  2564  				"md/raid:%s: read error on replacement device (sector %llu on %s).\n",
14a75d3e07c784 NeilBrown         2011-12-23  2565  				mdname(conf->mddev),
05616be5e11f66 NeilBrown         2012-05-21  2566  				(unsigned long long)s,
14a75d3e07c784 NeilBrown         2011-12-23  2567  				bdn);
2e8ac30312973d majianpeng        2012-07-03  2568  		else if (conf->mddev->degraded >= conf->max_degraded) {
2e8ac30312973d majianpeng        2012-07-03  2569  			set_bad = 1;
cc6167b4f3b3ca NeilBrown         2016-11-02  2570  			pr_warn_ratelimited(
cc6167b4f3b3ca NeilBrown         2016-11-02  2571  				"md/raid:%s: read error not correctable (sector %llu on %s).\n",
d69504325978c4 NeilBrown         2006-07-10  2572  				mdname(conf->mddev),
05616be5e11f66 NeilBrown         2012-05-21  2573  				(unsigned long long)s,
d69504325978c4 NeilBrown         2006-07-10  2574  				bdn);
2e8ac30312973d majianpeng        2012-07-03  2575  		} else if (test_bit(R5_ReWrite, &sh->dev[i].flags)) {
4e5314b56a7ea1 NeilBrown         2005-11-08  2576  			/* Oh, no!!! */
2e8ac30312973d majianpeng        2012-07-03  2577  			set_bad = 1;
cc6167b4f3b3ca NeilBrown         2016-11-02  2578  			pr_warn_ratelimited(
cc6167b4f3b3ca NeilBrown         2016-11-02  2579  				"md/raid:%s: read error NOT corrected!! (sector %llu on %s).\n",
d69504325978c4 NeilBrown         2006-07-10  2580  				mdname(conf->mddev),
05616be5e11f66 NeilBrown         2012-05-21  2581  				(unsigned long long)s,
d69504325978c4 NeilBrown         2006-07-10  2582  				bdn);
2e8ac30312973d majianpeng        2012-07-03  2583  		} else if (atomic_read(&rdev->read_errors)
0009fad0333708 Nigel Croxon      2019-08-21  2584  			 > conf->max_nr_stripes) {
0009fad0333708 Nigel Croxon      2019-08-21  2585  			if (!test_bit(Faulty, &rdev->flags)) {
0009fad0333708 Nigel Croxon      2019-08-21  2586  				pr_warn("md/raid:%s: %d read_errors > %d stripes\n",
0009fad0333708 Nigel Croxon      2019-08-21  2587  				    mdname(conf->mddev),
0009fad0333708 Nigel Croxon      2019-08-21  2588  				    atomic_read(&rdev->read_errors),
0009fad0333708 Nigel Croxon      2019-08-21  2589  				    conf->max_nr_stripes);
cc6167b4f3b3ca NeilBrown         2016-11-02  2590  				pr_warn("md/raid:%s: Too many read errors, failing device %s.\n",
d69504325978c4 NeilBrown         2006-07-10  2591  				    mdname(conf->mddev), bdn);
0009fad0333708 Nigel Croxon      2019-08-21  2592  			}
0009fad0333708 Nigel Croxon      2019-08-21  2593  		} else
ba22dcbf106338 NeilBrown         2005-11-08  2594  			retry = 1;
edfa1f651e9326 Bian Yu           2013-11-14  2595  		if (set_bad && test_bit(In_sync, &rdev->flags)
edfa1f651e9326 Bian Yu           2013-11-14  2596  		    && !test_bit(R5_ReadNoMerge, &sh->dev[i].flags))
edfa1f651e9326 Bian Yu           2013-11-14  2597  			retry = 1;
ba22dcbf106338 NeilBrown         2005-11-08  2598  		if (retry)
143f6e733b7305 Xiao Ni           2019-07-08  2599  			if (sh->qd_idx >= 0 && sh->pd_idx == i)
143f6e733b7305 Xiao Ni           2019-07-08  2600  				set_bit(R5_ReadError, &sh->dev[i].flags);
143f6e733b7305 Xiao Ni           2019-07-08  2601  			else if (test_bit(R5_ReadNoMerge, &sh->dev[i].flags)) {
ba22dcbf106338 NeilBrown         2005-11-08  2602  				set_bit(R5_ReadError, &sh->dev[i].flags);
3f9e7c140e4c4e majianpeng        2012-07-31  2603  				clear_bit(R5_ReadNoMerge, &sh->dev[i].flags);
3f9e7c140e4c4e majianpeng        2012-07-31  2604  			} else
3f9e7c140e4c4e majianpeng        2012-07-31  2605  				set_bit(R5_ReadNoMerge, &sh->dev[i].flags);
ba22dcbf106338 NeilBrown         2005-11-08  2606  		else {
4e5314b56a7ea1 NeilBrown         2005-11-08  2607  			clear_bit(R5_ReadError, &sh->dev[i].flags);
4e5314b56a7ea1 NeilBrown         2005-11-08  2608  			clear_bit(R5_ReWrite, &sh->dev[i].flags);
2e8ac30312973d majianpeng        2012-07-03  2609  			if (!(set_bad
2e8ac30312973d majianpeng        2012-07-03  2610  			      && test_bit(In_sync, &rdev->flags)
2e8ac30312973d majianpeng        2012-07-03  2611  			      && rdev_set_badblocks(
98afa1940ade70 Yufen Yu          2020-07-02  2612  					  rdev, sh->sector,
98afa1940ade70 Yufen Yu          2020-07-02  2613  					  conf->stripe_sectors, 0)))
d69504325978c4 NeilBrown         2006-07-10  2614  				md_error(conf->mddev, rdev);
ba22dcbf106338 NeilBrown         2005-11-08  2615  		}
^1da177e4c3f41 Linus Torvalds    2005-04-16  2616  	}
14a75d3e07c784 NeilBrown         2011-12-23  2617  	rdev_dec_pending(rdev, conf->mddev);
c94455558337ee Shaohua Li        2016-09-08  2618  	bio_reset(bi);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2619  	clear_bit(R5_LOCKED, &sh->dev[i].flags);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2620  	set_bit(STRIPE_HANDLE, &sh->state);
6d036f7d52e5a9 Shaohua Li        2015-08-13  2621  	raid5_release_stripe(sh);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2622  }
^1da177e4c3f41 Linus Torvalds    2005-04-16  2623  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--yrj/dFKFPuw6o+aM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--yrj/dFKFPuw6o+aM--
