Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964B0225706
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jul 2020 07:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgGTF0o (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jul 2020 01:26:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:55066 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTF0o (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 20 Jul 2020 01:26:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B643BAD83;
        Mon, 20 Jul 2020 05:26:46 +0000 (UTC)
Subject: Re: [PATCH V1 3/3] improve raid10 discard request
To:     Xiao Ni <xni@redhat.com>, song@kernel.org,
        linux-raid@vger.kernel.org
Cc:     ncroxon@redhat.com, heinzm@redhat.com
References: <1595221108-10137-1-git-send-email-xni@redhat.com>
 <1595221108-10137-4-git-send-email-xni@redhat.com>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Message-ID: <ead4cd95-3a17-7ab6-3494-d1ac6bcc4d1f@suse.de>
Date:   Mon, 20 Jul 2020 13:26:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595221108-10137-4-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2020/7/20 12:58, Xiao Ni wrote:
> Now the discard request is split by chunk size. So it takes a long time to finish mkfs on
> disks which support discard function. This patch improve handling raid10 discard request.
> It uses  the similar way with raid0(29efc390b).
> 
> But it's a little complex than raid0. Because raid10 has different layout. If raid10 is
> offset layout and the discard request is smaller than stripe size. There are some holes
> when we submit discard bio to underlayer disks.
> 
> For example: five disks (disk1 - disk5)
> D01 D02 D03 D04 D05
> D05 D01 D02 D03 D04
> D06 D07 D08 D09 D10
> D10 D06 D07 D08 D09
> The discard bio just wants to discard from D03 to D10. For disk3, there is a hole between
> D03 and D08. For disk4, there is a hole between D04 and D09. D03 is a chunk, raid10_write_request
> can handle one chunk perfectly. So the part that is not aligned with stripe size is still
> handled by raid10_write_request.
> 
> If reshape is running when discard bio comes and the discard bio spans the reshape position,
> raid10_write_request is responsible to handle this discard bio.
> 
> I did a test with this patch set.
> Without patch:
> time mkfs.xfs /dev/md0
> real4m39.775s
> user0m0.000s
> sys0m0.298s
> 
> With patch:
> time mkfs.xfs /dev/md0
> real0m0.105s
> user0m0.000s
> sys0m0.007s
> 
> nvme3n1           259:1    0   477G  0 disk
> └─nvme3n1p1       259:10   0    50G  0 part
> nvme4n1           259:2    0   477G  0 disk
> └─nvme4n1p1       259:11   0    50G  0 part
> nvme5n1           259:6    0   477G  0 disk
> └─nvme5n1p1       259:12   0    50G  0 part
> nvme2n1           259:9    0   477G  0 disk
> └─nvme2n1p1       259:15   0    50G  0 part
> nvme0n1           259:13   0   477G  0 disk
> └─nvme0n1p1       259:14   0    50G  0 part
> 
> v1:
> Coly helps to review these patches and give some suggestions:
> One bug is found. If discard bio is across one stripe but bio size is bigger
> than one stripe size. After spliting, the bio will be NULL. In this version,
> it checks whether discard bio size is bigger than 2*stripe_size.
> In raid10_end_discard_request, it's better to check R10BIO_Uptodate is set
> or not. It can avoid write memory to improve performance.
> Add more comments for calculating addresses.
> 
> Signed-off-by: Xiao Ni <xni@redhat.com>

The code looks good to me, you may add my Reviewed-by: Coly Li
<colyli@suse.de>

But I still suggest you to add a more detailed commit log, to explain
how the discard range of each component disk is decided. Anyway this is
just a suggestion, it is up to you.

Thank you for this work.


Coly Li

> ---
>  drivers/md/raid10.c | 276 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 275 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 2a7423e..9568c23 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -1518,6 +1518,271 @@ static void __make_request(struct mddev *mddev, struct bio *bio, int sectors)
>  		raid10_write_request(mddev, bio, r10_bio);
>  }
>  
> +static void wait_blocked_dev(struct mddev *mddev, int cnt)
> +{
> +	int i;
> +	struct r10conf *conf = mddev->private;
> +	struct md_rdev *blocked_rdev = NULL;
> +
> +retry_wait:
> +	rcu_read_lock();
> +	for (i = 0; i < cnt; i++) {
> +		struct md_rdev *rdev = rcu_dereference(conf->mirrors[i].rdev);
> +		struct md_rdev *rrdev = rcu_dereference(
> +			conf->mirrors[i].replacement);
> +		if (rdev == rrdev)
> +			rrdev = NULL;
> +		if (rdev && unlikely(test_bit(Blocked, &rdev->flags))) {
> +			atomic_inc(&rdev->nr_pending);
> +			blocked_rdev = rdev;
> +			break;
> +		}
> +		if (rrdev && unlikely(test_bit(Blocked, &rrdev->flags))) {
> +			atomic_inc(&rrdev->nr_pending);
> +			blocked_rdev = rrdev;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	if (unlikely(blocked_rdev)) {
> +		/* Have to wait for this device to get unblocked, then retry */
> +		allow_barrier(conf);
> +		raid10_log(conf->mddev, "%s wait rdev %d blocked", __func__, blocked_rdev->raid_disk);
> +		md_wait_for_blocked_rdev(blocked_rdev, mddev);
> +		wait_barrier(conf);
> +		goto retry_wait;
> +	}
> +}
> +
> +static struct bio *raid10_split_bio(struct r10conf *conf,
> +			struct bio *bio, sector_t sectors, bool want_first)
> +{
> +	struct bio *split;
> +
> +	split = bio_split(bio, sectors,	GFP_NOIO, &conf->bio_split);
> +	bio_chain(split, bio);
> +	allow_barrier(conf);
> +	if (want_first) {
> +		submit_bio_noacct(bio);
> +		bio = split;
> +	} else
> +		submit_bio_noacct(split);
> +	wait_barrier(conf);
> +
> +	return bio;
> +}
> +
> +static void raid10_end_discard_request(struct bio *bio)
> +{
> +	struct r10bio *r10_bio = bio->bi_private;
> +        struct r10conf *conf = r10_bio->mddev->private;
> +	struct md_rdev *rdev = NULL;
> +        int dev;
> +        int slot, repl;
> +
> +	/*
> +	 * We don't care the return value of discard bio
> +	 */
> +	if (!test_bit(R10BIO_Uptodate, &r10_bio->state))
> +		set_bit(R10BIO_Uptodate, &r10_bio->state);
> +
> +	dev = find_bio_disk(conf, r10_bio, bio, &slot, &repl);
> +	if (repl)
> +		rdev = conf->mirrors[dev].replacement;
> +	if (!rdev) {
> +		smp_rmb();
> +		repl = 0;
> +		rdev = conf->mirrors[dev].rdev;
> +	}
> +
> +	if (atomic_dec_and_test(&r10_bio->remaining)) {
> +		md_write_end(r10_bio->mddev);
> +		raid_end_bio_io(r10_bio);
> +	}
> +
> +	rdev_dec_pending(rdev, conf->mddev);
> +}
> +
> +static bool raid10_handle_discard(struct mddev *mddev, struct bio *bio)
> +{
> +	struct r10conf *conf = mddev->private;
> +	struct geom geo = conf->geo;
> +	struct r10bio *r10_bio;
> +
> +	int disk;
> +	sector_t chunk;
> +	int stripe_size, stripe_mask;
> +
> +	sector_t bio_start, bio_end;
> +	sector_t first_stripe_index, last_stripe_index;
> +	sector_t start_disk_offset;
> +	unsigned int start_disk_index;
> +	sector_t end_disk_offset;
> +	unsigned int end_disk_index;
> +
> +	wait_barrier(conf);
> +
> +	if (conf->reshape_progress != MaxSector &&
> +	    ((bio->bi_iter.bi_sector >= conf->reshape_progress) !=
> +	     conf->mddev->reshape_backwards))
> +		geo = conf->prev;
> +
> +	stripe_size = (1<<geo.chunk_shift) * geo.raid_disks;
> +	stripe_mask = stripe_size - 1;
> +
> +	/* Maybe one discard bio is smaller than strip size or across one stripe
> +	 * and discard region is larger than one stripe size. For far offset layout,
> +	 * if the discard region is not aligned with stripe size, there is hole
> +	 * when we submit discard bio to member disk. For simplicity, we only
> +	 * handle discard bio which discard region is bigger than stripe_size*2
> +	 */
> +	if (bio_sectors(bio) < stripe_size*2)
> +		goto out;
> +
> +	if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
> +	     bio->bi_iter.bi_sector < conf->reshape_progress &&
> +	     bio->bi_iter.bi_sector + bio_sectors(bio) > conf->reshape_progress)
> +		goto out;
> +
> +	r10_bio = mempool_alloc(&conf->r10bio_pool, GFP_NOIO);
> +	r10_bio->mddev = mddev;
> +	r10_bio->state = 0;
> +	memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->geo.raid_disks);
> +
> +	wait_blocked_dev(mddev, geo.raid_disks);
> +
> +	/* For far offset layout, if bio is not aligned with stripe size, it splits
> +	 * the part that is not aligned with strip size.
> +	 */
> +	bio_start = bio->bi_iter.bi_sector;
> +	bio_end = bio_end_sector(bio);
> +	if (geo.far_offset && (bio_start & stripe_mask)) {
> +		sector_t split_size;
> +		split_size = round_up(bio_start, stripe_size) - bio_start;
> +		bio = raid10_split_bio(conf, bio, split_size, false);
> +	}
> +	if (geo.far_offset && ((bio_end & stripe_mask) != stripe_mask)) {
> +		sector_t split_size;
> +		split_size = bio_end - (bio_end & stripe_mask);
> +		bio = raid10_split_bio(conf, bio, split_size, true);
> +	}
> +	r10_bio->master_bio = bio;
> +
> +	bio_start = bio->bi_iter.bi_sector;
> +	bio_end = bio_end_sector(bio);
> +
> +	/* raid10 uses chunk as the unit to store data. It's similar like raid0.
> +	 * One stripe contains the chunks from all member disk (one chunk from
> +	 * one disk at the same HAB address). For layout detail, see 'man md 4'
> +	 */
> +	chunk = bio_start >> geo.chunk_shift;
> +	chunk *= geo.near_copies;
> +	first_stripe_index = chunk;
> +	start_disk_index = sector_div(first_stripe_index, geo.raid_disks);
> +	if (geo.far_offset)
> +		first_stripe_index *= geo.far_copies;
> +	start_disk_offset = (bio_start & geo.chunk_mask) +
> +				(first_stripe_index << geo.chunk_shift);
> +
> +	chunk = bio_end >> geo.chunk_shift;
> +	chunk *= geo.near_copies;
> +	last_stripe_index = chunk;
> +	end_disk_index = sector_div(last_stripe_index, geo.raid_disks);
> +	if (geo.far_offset)
> +		last_stripe_index *= geo.far_copies;
> +	end_disk_offset = (bio_end & geo.chunk_mask) +
> +				(last_stripe_index << geo.chunk_shift);
> +
> +	rcu_read_lock();
> +	for (disk = 0; disk < geo.raid_disks; disk++) {
> +		struct md_rdev *rdev = rcu_dereference(conf->mirrors[disk].rdev);
> +		struct md_rdev *rrdev = rcu_dereference(
> +			conf->mirrors[disk].replacement);
> +
> +		r10_bio->devs[disk].bio = NULL;
> +		r10_bio->devs[disk].repl_bio = NULL;
> +
> +		if (rdev && (test_bit(Faulty, &rdev->flags)))
> +			rdev = NULL;
> +		if (rrdev && (test_bit(Faulty, &rrdev->flags)))
> +			rrdev = NULL;
> +		if (!rdev && !rrdev)
> +			continue;
> +
> +		if (rdev) {
> +			r10_bio->devs[disk].bio = bio;
> +			atomic_inc(&rdev->nr_pending);
> +		}
> +		if (rrdev) {
> +			r10_bio->devs[disk].repl_bio = bio;
> +			atomic_inc(&rrdev->nr_pending);
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +	atomic_set(&r10_bio->remaining, 1);
> +	for (disk = 0; disk < geo.raid_disks; disk++) {
> +		sector_t dev_start, dev_end;
> +		struct bio *mbio, *rbio = NULL;
> +		struct md_rdev *rdev = rcu_dereference(conf->mirrors[disk].rdev);
> +		struct md_rdev *rrdev = rcu_dereference(
> +			conf->mirrors[disk].replacement);
> +
> +		/*
> +		 * Now start to calculate the start and end address for each disk.
> +		 * The space between dev_start and dev_end is the discard region.
> +		 */
> +		if (disk < start_disk_index)
> +			dev_start = (first_stripe_index + 1) * mddev->chunk_sectors;
> +		else if (disk > start_disk_index)
> +			dev_start = first_stripe_index * mddev->chunk_sectors;
> +		else
> +			dev_start = start_disk_offset;
> +
> +		if (disk < end_disk_index)
> +			dev_end = (last_stripe_index + 1) * mddev->chunk_sectors;
> +		else if (disk > end_disk_index)
> +			dev_end = last_stripe_index * mddev->chunk_sectors;
> +		else
> +			dev_end = end_disk_offset;
> +
> +		/* It only handles discard bio which size is >= stripe size, so
> +		 * dev_end > dev_start all the time
> +		 */
> +		if (r10_bio->devs[disk].bio) {
> +			mbio = bio_clone_fast(bio, GFP_NOIO, &mddev->bio_set);
> +			mbio->bi_end_io = raid10_end_discard_request;
> +			mbio->bi_private = r10_bio;
> +			r10_bio->devs[disk].bio = mbio;
> +			r10_bio->devs[disk].devnum = disk;
> +			atomic_inc(&r10_bio->remaining);
> +			md_submit_discard_bio(mddev, rdev, mbio, dev_start, dev_end);
> +			bio_endio(mbio);
> +		}
> +		if (r10_bio->devs[disk].repl_bio) {
> +			rbio = bio_clone_fast(bio, GFP_NOIO, &mddev->bio_set);
> +			rbio->bi_end_io = raid10_end_discard_request;
> +			rbio->bi_private = r10_bio;
> +			r10_bio->devs[disk].repl_bio = rbio;
> +			r10_bio->devs[disk].devnum = disk;
> +			atomic_inc(&r10_bio->remaining);
> +			md_submit_discard_bio(mddev, rrdev, rbio, dev_start, dev_end);
> +			bio_endio(rbio);
> +		}
> +	}
> +
> +	if (atomic_dec_and_test(&r10_bio->remaining)) {
> +		md_write_end(r10_bio->mddev);
> +		raid_end_bio_io(r10_bio);
> +	}
> +
> +	return 0;
> +out:
> +	allow_barrier(conf);
> +	return -EAGAIN;
> +}
> +
>  static bool raid10_make_request(struct mddev *mddev, struct bio *bio)
>  {
>  	struct r10conf *conf = mddev->private;
> @@ -1532,6 +1797,15 @@ static bool raid10_make_request(struct mddev *mddev, struct bio *bio)
>  	if (!md_write_start(mddev, bio))
>  		return false;
>  
> +	/* There are some limitations to handle discard bio
> +	 * 1st, the discard size is bigger than stripe size.
> +	 * 2st, if the discard bio spans reshape progress, we use the old way to
> +	 * handle discard bio
> +	 */
> +	if (unlikely(bio_op(bio) == REQ_OP_DISCARD))
> +		if (!raid10_handle_discard(mddev, bio))
> +			return true;
> +
>  	/*
>  	 * If this request crosses a chunk boundary, we need to split
>  	 * it.
> @@ -3762,7 +4036,7 @@ static int raid10_run(struct mddev *mddev)
>  	chunk_size = mddev->chunk_sectors << 9;
>  	if (mddev->queue) {
>  		blk_queue_max_discard_sectors(mddev->queue,
> -					      mddev->chunk_sectors);
> +					      UINT_MAX);
>  		blk_queue_max_write_same_sectors(mddev->queue, 0);
>  		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
>  		blk_queue_io_min(mddev->queue, chunk_size);
> 

