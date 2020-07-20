Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0352256F8
	for <lists+linux-raid@lfdr.de>; Mon, 20 Jul 2020 07:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgGTFPY (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 20 Jul 2020 01:15:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:53072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgGTFPY (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 20 Jul 2020 01:15:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F87CB7F1;
        Mon, 20 Jul 2020 05:15:28 +0000 (UTC)
Subject: Re: [PATCH V1 2/3] extend r10bio devs to raid disks
To:     Xiao Ni <xni@redhat.com>, song@kernel.org,
        linux-raid@vger.kernel.org
Cc:     ncroxon@redhat.com, heinzm@redhat.com
References: <1595221108-10137-1-git-send-email-xni@redhat.com>
 <1595221108-10137-3-git-send-email-xni@redhat.com>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Message-ID: <eeb6faad-cb05-b831-0108-6222f122d7d3@suse.de>
Date:   Mon, 20 Jul 2020 13:15:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595221108-10137-3-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2020/7/20 12:58, Xiao Ni wrote:
> Now it allocs r10bio->devs[conf->copies]. Discard bio needs to submit to all member disks
> and it needs to use r10bio. So extend to r10bio->devs[geo.raid_disks].
> 
> Signed-off-by: Xiao Ni <xni@redhat.com>

Reviewed-by: Coly Li <colyli@suse.de>



Coly Li


> ---
>  drivers/md/raid10.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index e45fd56..2a7423e 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -91,7 +91,7 @@ static inline struct r10bio *get_resync_r10bio(struct bio *bio)
>  static void * r10bio_pool_alloc(gfp_t gfp_flags, void *data)
>  {
>  	struct r10conf *conf = data;
> -	int size = offsetof(struct r10bio, devs[conf->copies]);
> +	int size = offsetof(struct r10bio, devs[conf->geo.raid_disks]);
>  
>  	/* allocate a r10bio with room for raid_disks entries in the
>  	 * bios array */
> @@ -238,7 +238,7 @@ static void put_all_bios(struct r10conf *conf, struct r10bio *r10_bio)
>  {
>  	int i;
>  
> -	for (i = 0; i < conf->copies; i++) {
> +	for (i = 0; i < conf->geo.raid_disks; i++) {
>  		struct bio **bio = & r10_bio->devs[i].bio;
>  		if (!BIO_SPECIAL(*bio))
>  			bio_put(*bio);
> @@ -327,7 +327,7 @@ static int find_bio_disk(struct r10conf *conf, struct r10bio *r10_bio,
>  	int slot;
>  	int repl = 0;
>  
> -	for (slot = 0; slot < conf->copies; slot++) {
> +	for (slot = 0; slot < conf->geo.raid_disks; slot++) {
>  		if (r10_bio->devs[slot].bio == bio)
>  			break;
>  		if (r10_bio->devs[slot].repl_bio == bio) {
> @@ -336,7 +336,7 @@ static int find_bio_disk(struct r10conf *conf, struct r10bio *r10_bio,
>  		}
>  	}
>  
> -	BUG_ON(slot == conf->copies);
> +	BUG_ON(slot == conf->geo.raid_disks);
>  	update_head_pos(slot, r10_bio);
>  
>  	if (slotp)
> @@ -1510,7 +1510,7 @@ static void __make_request(struct mddev *mddev, struct bio *bio, int sectors)
>  	r10_bio->mddev = mddev;
>  	r10_bio->sector = bio->bi_iter.bi_sector;
>  	r10_bio->state = 0;
> -	memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->copies);
> +	memset(r10_bio->devs, 0, sizeof(r10_bio->devs[0]) * conf->geo.raid_disks);
>  
>  	if (bio_data_dir(bio) == READ)
>  		raid10_read_request(mddev, bio, r10_bio);
> 

