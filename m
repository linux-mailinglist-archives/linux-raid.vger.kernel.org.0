Return-Path: <linux-raid+bounces-3054-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6BB9B723A
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2024 02:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D04E28227F
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2024 01:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D20D84D29;
	Thu, 31 Oct 2024 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSAOmPNx"
X-Original-To: linux-raid@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E284D0D;
	Thu, 31 Oct 2024 01:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730339332; cv=none; b=ENrDqHvK1/2Iw0L/1oXtf/rZ1aShYPBE+qra4cRjHMh/9IGZde/GP1bL8gY1/EktwjXNuDNTdiMvGnGyz79RWCDzMZwvuWs3/yQC3yGu2WPZEy39/0Xute3ZzAhNpKvkMQa0QT2Z1k7HZu8wHryBkVu7Vtq5iLNMfkIqXmvNqx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730339332; c=relaxed/simple;
	bh=qdnlyPcJDq98waWANYquPT+gUnUwiHoHoenDLs5YNC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mE/vMzOpvqz9UpTS6P0BtFwes4iN4edB25i/4ZBhApkSJlSVOfq9oy6TBCbcj211s5FIh5db4c+SvwhE+SDhMZufqr5Pz9+s3WNHlwEqf6UCIJCEQehahkAFZNRYZHN9+PVFm9FKDiHtDSj4C9Vhfex9uHTedghLPI8hiKO/09g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSAOmPNx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730339329; x=1761875329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qdnlyPcJDq98waWANYquPT+gUnUwiHoHoenDLs5YNC0=;
  b=HSAOmPNxbfX0GUv1SdYZslejJJ7FrchW21IDZTfQ5mnbgL59X+boPEkg
   qEIvWadM3y8YpOXO56EuJzMrsL2uOPef93tm2GzVyF8Uxz1xTq1k/WBsm
   PYlg1+a8ELSsDQ/nQTMBARLUgIjzxMrsk8M4d4rYR3TC//ZChkHYA1vpf
   B0gUvorCCKg2ypyCNIxlfcAcvK1WG2nJLIA0KOY31WI09AP66C5fb7df5
   xhXUHikR00dYGzcTEPA9vBwN1csxBLPvInl57yjcnimv8gHy+gEvEZ4j4
   4HvkOWS+mjweJON0IqwrPXklarkM1GW1GOBNBxMwChNh1EDeuNxpBfRTS
   Q==;
X-CSE-ConnectionGUID: ixsvp+4xR8OfcaZ+0q3CVA==
X-CSE-MsgGUID: wNyS0Nr9TZuJvlk9wYzfNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11241"; a="30170852"
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="30170852"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 18:48:48 -0700
X-CSE-ConnectionGUID: cf9N/qipSSeG2YvXvu1HDg==
X-CSE-MsgGUID: aBDAZ4AFQRiyoXkgQrC3cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,246,1725346800"; 
   d="scan'208";a="87632224"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Oct 2024 18:48:45 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6KIl-000fWG-0o;
	Thu, 31 Oct 2024 01:48:43 +0000
Date: Thu, 31 Oct 2024 09:47:59 +0800
From: kernel test robot <lkp@intel.com>
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, song@kernel.org,
	yukuai3@huawei.com, hch@lst.de
Cc: oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v2 4/5] md/raid1: Atomic write support
Message-ID: <202410310901.jvlF3M0r-lkp@intel.com>
References: <20241030094912.3960234-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030094912.3960234-5-john.g.garry@oracle.com>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.12-rc5 next-20241030]
[cannot apply to song-md/md-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Garry/block-Add-extra-checks-in-blk_validate_atomic_write_limits/20241030-175428
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20241030094912.3960234-5-john.g.garry%40oracle.com
patch subject: [PATCH v2 4/5] md/raid1: Atomic write support
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241031/202410310901.jvlF3M0r-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241031/202410310901.jvlF3M0r-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410310901.jvlF3M0r-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/md/raid1.c: In function 'raid1_write_request':
>> drivers/md/raid1.c:1519:33: error: 'error' undeclared (first use in this function); did you mean 'md_error'?
    1519 |                                 error = -EFAULT;
         |                                 ^~~~~
         |                                 md_error
   drivers/md/raid1.c:1519:33: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/md/raid1.c:1520:33: error: label 'err_handle' used but not defined
    1520 |                                 goto err_handle;
         |                                 ^~~~


vim +1519 drivers/md/raid1.c

  1414	
  1415	static void raid1_write_request(struct mddev *mddev, struct bio *bio,
  1416					int max_write_sectors)
  1417	{
  1418		struct r1conf *conf = mddev->private;
  1419		struct r1bio *r1_bio;
  1420		int i, disks;
  1421		unsigned long flags;
  1422		struct md_rdev *blocked_rdev;
  1423		int first_clone;
  1424		int max_sectors;
  1425		bool write_behind = false;
  1426		bool is_discard = (bio_op(bio) == REQ_OP_DISCARD);
  1427	
  1428		if (mddev_is_clustered(mddev) &&
  1429		     md_cluster_ops->area_resyncing(mddev, WRITE,
  1430			     bio->bi_iter.bi_sector, bio_end_sector(bio))) {
  1431	
  1432			DEFINE_WAIT(w);
  1433			if (bio->bi_opf & REQ_NOWAIT) {
  1434				bio_wouldblock_error(bio);
  1435				return;
  1436			}
  1437			for (;;) {
  1438				prepare_to_wait(&conf->wait_barrier,
  1439						&w, TASK_IDLE);
  1440				if (!md_cluster_ops->area_resyncing(mddev, WRITE,
  1441								bio->bi_iter.bi_sector,
  1442								bio_end_sector(bio)))
  1443					break;
  1444				schedule();
  1445			}
  1446			finish_wait(&conf->wait_barrier, &w);
  1447		}
  1448	
  1449		/*
  1450		 * Register the new request and wait if the reconstruction
  1451		 * thread has put up a bar for new requests.
  1452		 * Continue immediately if no resync is active currently.
  1453		 */
  1454		if (!wait_barrier(conf, bio->bi_iter.bi_sector,
  1455					bio->bi_opf & REQ_NOWAIT)) {
  1456			bio_wouldblock_error(bio);
  1457			return;
  1458		}
  1459	
  1460	 retry_write:
  1461		r1_bio = alloc_r1bio(mddev, bio);
  1462		r1_bio->sectors = max_write_sectors;
  1463	
  1464		/* first select target devices under rcu_lock and
  1465		 * inc refcount on their rdev.  Record them by setting
  1466		 * bios[x] to bio
  1467		 * If there are known/acknowledged bad blocks on any device on
  1468		 * which we have seen a write error, we want to avoid writing those
  1469		 * blocks.
  1470		 * This potentially requires several writes to write around
  1471		 * the bad blocks.  Each set of writes gets it's own r1bio
  1472		 * with a set of bios attached.
  1473		 */
  1474	
  1475		disks = conf->raid_disks * 2;
  1476		blocked_rdev = NULL;
  1477		max_sectors = r1_bio->sectors;
  1478		for (i = 0;  i < disks; i++) {
  1479			struct md_rdev *rdev = conf->mirrors[i].rdev;
  1480	
  1481			/*
  1482			 * The write-behind io is only attempted on drives marked as
  1483			 * write-mostly, which means we could allocate write behind
  1484			 * bio later.
  1485			 */
  1486			if (!is_discard && rdev && test_bit(WriteMostly, &rdev->flags))
  1487				write_behind = true;
  1488	
  1489			if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
  1490				atomic_inc(&rdev->nr_pending);
  1491				blocked_rdev = rdev;
  1492				break;
  1493			}
  1494			r1_bio->bios[i] = NULL;
  1495			if (!rdev || test_bit(Faulty, &rdev->flags)) {
  1496				if (i < conf->raid_disks)
  1497					set_bit(R1BIO_Degraded, &r1_bio->state);
  1498				continue;
  1499			}
  1500	
  1501			atomic_inc(&rdev->nr_pending);
  1502			if (test_bit(WriteErrorSeen, &rdev->flags)) {
  1503				sector_t first_bad;
  1504				int bad_sectors;
  1505				int is_bad;
  1506	
  1507				is_bad = is_badblock(rdev, r1_bio->sector, max_sectors,
  1508						     &first_bad, &bad_sectors);
  1509				if (is_bad < 0) {
  1510					/* mustn't write here until the bad block is
  1511					 * acknowledged*/
  1512					set_bit(BlockedBadBlocks, &rdev->flags);
  1513					blocked_rdev = rdev;
  1514					break;
  1515				}
  1516	
  1517				if (is_bad && bio->bi_opf & REQ_ATOMIC) {
  1518					/* We just cannot atomically write this ... */
> 1519					error = -EFAULT;
> 1520					goto err_handle;
  1521				}
  1522	
  1523				if (is_bad && first_bad <= r1_bio->sector) {
  1524					/* Cannot write here at all */
  1525					bad_sectors -= (r1_bio->sector - first_bad);
  1526					if (bad_sectors < max_sectors)
  1527						/* mustn't write more than bad_sectors
  1528						 * to other devices yet
  1529						 */
  1530						max_sectors = bad_sectors;
  1531					rdev_dec_pending(rdev, mddev);
  1532					/* We don't set R1BIO_Degraded as that
  1533					 * only applies if the disk is
  1534					 * missing, so it might be re-added,
  1535					 * and we want to know to recover this
  1536					 * chunk.
  1537					 * In this case the device is here,
  1538					 * and the fact that this chunk is not
  1539					 * in-sync is recorded in the bad
  1540					 * block log
  1541					 */
  1542					continue;
  1543				}
  1544				if (is_bad) {
  1545					int good_sectors = first_bad - r1_bio->sector;
  1546					if (good_sectors < max_sectors)
  1547						max_sectors = good_sectors;
  1548				}
  1549			}
  1550			r1_bio->bios[i] = bio;
  1551		}
  1552	
  1553		if (unlikely(blocked_rdev)) {
  1554			/* Wait for this device to become unblocked */
  1555			int j;
  1556	
  1557			for (j = 0; j < i; j++)
  1558				if (r1_bio->bios[j])
  1559					rdev_dec_pending(conf->mirrors[j].rdev, mddev);
  1560			mempool_free(r1_bio, &conf->r1bio_pool);
  1561			allow_barrier(conf, bio->bi_iter.bi_sector);
  1562	
  1563			if (bio->bi_opf & REQ_NOWAIT) {
  1564				bio_wouldblock_error(bio);
  1565				return;
  1566			}
  1567			mddev_add_trace_msg(mddev, "raid1 wait rdev %d blocked",
  1568					blocked_rdev->raid_disk);
  1569			md_wait_for_blocked_rdev(blocked_rdev, mddev);
  1570			wait_barrier(conf, bio->bi_iter.bi_sector, false);
  1571			goto retry_write;
  1572		}
  1573	
  1574		/*
  1575		 * When using a bitmap, we may call alloc_behind_master_bio below.
  1576		 * alloc_behind_master_bio allocates a copy of the data payload a page
  1577		 * at a time and thus needs a new bio that can fit the whole payload
  1578		 * this bio in page sized chunks.
  1579		 */
  1580		if (write_behind && mddev->bitmap)
  1581			max_sectors = min_t(int, max_sectors,
  1582					    BIO_MAX_VECS * (PAGE_SIZE >> 9));
  1583		if (max_sectors < bio_sectors(bio)) {
  1584			struct bio *split = bio_split(bio, max_sectors,
  1585						      GFP_NOIO, &conf->bio_split);
  1586			bio_chain(split, bio);
  1587			submit_bio_noacct(bio);
  1588			bio = split;
  1589			r1_bio->master_bio = bio;
  1590			r1_bio->sectors = max_sectors;
  1591		}
  1592	
  1593		md_account_bio(mddev, &bio);
  1594		r1_bio->master_bio = bio;
  1595		atomic_set(&r1_bio->remaining, 1);
  1596		atomic_set(&r1_bio->behind_remaining, 0);
  1597	
  1598		first_clone = 1;
  1599	
  1600		for (i = 0; i < disks; i++) {
  1601			struct bio *mbio = NULL;
  1602			struct md_rdev *rdev = conf->mirrors[i].rdev;
  1603			if (!r1_bio->bios[i])
  1604				continue;
  1605	
  1606			if (first_clone) {
  1607				unsigned long max_write_behind =
  1608					mddev->bitmap_info.max_write_behind;
  1609				struct md_bitmap_stats stats;
  1610				int err;
  1611	
  1612				/* do behind I/O ?
  1613				 * Not if there are too many, or cannot
  1614				 * allocate memory, or a reader on WriteMostly
  1615				 * is waiting for behind writes to flush */
  1616				err = mddev->bitmap_ops->get_stats(mddev->bitmap, &stats);
  1617				if (!err && write_behind && !stats.behind_wait &&
  1618				    stats.behind_writes < max_write_behind)
  1619					alloc_behind_master_bio(r1_bio, bio);
  1620	
  1621				mddev->bitmap_ops->startwrite(
  1622					mddev, r1_bio->sector, r1_bio->sectors,
  1623					test_bit(R1BIO_BehindIO, &r1_bio->state));
  1624				first_clone = 0;
  1625			}
  1626	
  1627			if (r1_bio->behind_master_bio) {
  1628				mbio = bio_alloc_clone(rdev->bdev,
  1629						       r1_bio->behind_master_bio,
  1630						       GFP_NOIO, &mddev->bio_set);
  1631				if (test_bit(CollisionCheck, &rdev->flags))
  1632					wait_for_serialization(rdev, r1_bio);
  1633				if (test_bit(WriteMostly, &rdev->flags))
  1634					atomic_inc(&r1_bio->behind_remaining);
  1635			} else {
  1636				mbio = bio_alloc_clone(rdev->bdev, bio, GFP_NOIO,
  1637						       &mddev->bio_set);
  1638	
  1639				if (mddev->serialize_policy)
  1640					wait_for_serialization(rdev, r1_bio);
  1641			}
  1642	
  1643			r1_bio->bios[i] = mbio;
  1644	
  1645			mbio->bi_iter.bi_sector	= (r1_bio->sector + rdev->data_offset);
  1646			mbio->bi_end_io	= raid1_end_write_request;
  1647			mbio->bi_opf = bio_op(bio) | (bio->bi_opf & (REQ_SYNC | REQ_FUA));
  1648			if (test_bit(FailFast, &rdev->flags) &&
  1649			    !test_bit(WriteMostly, &rdev->flags) &&
  1650			    conf->raid_disks - mddev->degraded > 1)
  1651				mbio->bi_opf |= MD_FAILFAST;
  1652			mbio->bi_private = r1_bio;
  1653	
  1654			atomic_inc(&r1_bio->remaining);
  1655			mddev_trace_remap(mddev, mbio, r1_bio->sector);
  1656			/* flush_pending_writes() needs access to the rdev so...*/
  1657			mbio->bi_bdev = (void *)rdev;
  1658			if (!raid1_add_bio_to_plug(mddev, mbio, raid1_unplug, disks)) {
  1659				spin_lock_irqsave(&conf->device_lock, flags);
  1660				bio_list_add(&conf->pending_bio_list, mbio);
  1661				spin_unlock_irqrestore(&conf->device_lock, flags);
  1662				md_wakeup_thread(mddev->thread);
  1663			}
  1664		}
  1665	
  1666		r1_bio_write_done(r1_bio);
  1667	
  1668		/* In case raid1d snuck in to freeze_array */
  1669		wake_up_barrier(conf);
  1670	}
  1671	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

