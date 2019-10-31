Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62D93EB969
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2019 22:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfJaV4x (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 31 Oct 2019 17:56:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38395 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbfJaV4x (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 31 Oct 2019 17:56:53 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dann.frazier@canonical.com>)
        id 1iQIQx-0001rO-IR
        for linux-raid@vger.kernel.org; Thu, 31 Oct 2019 21:56:47 +0000
Received: by mail-io1-f72.google.com with SMTP id q84so5719349iod.15
        for <linux-raid@vger.kernel.org>; Thu, 31 Oct 2019 14:56:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z7rbnpmoug5tZa7wFexq7fCcQd1LOus6ad4ZOEikGnE=;
        b=FI7ByWfZ01TeSkyTqWbRDPb8GlJAx+rAU2M+vSMxH2mOrcMlxcaKrs8buP93uw2r/2
         nB8TtBKRsmOzJq9awpIKf/WYwJMulaphgqSzswhY0wK3Uof3LejOUZqoJX2ziFnAR7hi
         0FwST2XygNtcOpmRk45qpigz0MvEay9fkLLli3V/ighUZuAn0NI+8ClZwsiyT58HsAo3
         uT9DtDHuY379gt5xL+aoi+8s4GGvnrnUHHaZNH39GIf/YbpkZMAkIdprZa9swLn1lNRT
         hlnIm/0dgOVXWXfjtsCdC8iCFGa7BfB3l0kmlJhYXuO77o1LhSrYOFXSv/9KzrBaMnR9
         de0A==
X-Gm-Message-State: APjAAAWX/j+C/F46dS/Vm/dmu7Glm9nImg5ZkOke5V+8KVkdFpYreo4o
        hybLNJ4fGJ84S2Wej7X57yrhyPW0ocApZxg/56IEF2x09oFpF4oOgYraXcx8P2u6l/pjoMLlghz
        agjlmz41U4+tYCjdHorwZG75iVISxw2AO1RnGtDo=
X-Received: by 2002:a92:d643:: with SMTP id x3mr9015515ilp.203.1572559006347;
        Thu, 31 Oct 2019 14:56:46 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+c00ecZwpBrX2nvD8iWDPLl3MbJ4tf8FJVgVV74HeUxZz5fZ3TlEbjoHm7wca/+vp7L3tuw==
X-Received: by 2002:a92:d643:: with SMTP id x3mr9015469ilp.203.1572559005713;
        Thu, 31 Oct 2019 14:56:45 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id k3sm255040iob.74.2019.10.31.14.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 14:56:44 -0700 (PDT)
Date:   Thu, 31 Oct 2019 15:56:44 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>, linux-raid@vger.kernel.org,
        Song Liu <liu.song.a23@gmail.com>
Subject: Re: [PATCH 1/2] Create: add support for RAID0 layouts.
Message-ID: <20191031215644.GB24512@xps13.dannf>
References: <157247951643.8013.12020039865359474811.stgit@noble.brown>
 <157247976449.8013.11231492614839148435.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157247976449.8013.11231492614839148435.stgit@noble.brown>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Oct 31, 2019 at 10:56:04AM +1100, NeilBrown wrote:
> Since Linux 5.4 a layout is needed for RAID0 arrays with
> varying device sizes.

Thanks for working on this. It will be key to backport to distros
along w/ the kernel side.

> This patch makes the layout of an array visible (via --examine)
> and sets the layout on newly created arrays.

Probably a n00b question - but why is this visible in --examine but not
--detail? Seems like a feature of the array vs. the members.

> --layout=dangerous
> can be used to avoid setting a layout so that they array
> can be used on older kernels.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  Create.c   |   11 +++++++++++
>  maps.c     |   12 ++++++++++++
>  md.4       |   14 ++++++++++++++
>  mdadm.8.in |   30 +++++++++++++++++++++++++++++-
>  mdadm.c    |    8 ++++++++
>  mdadm.h    |    8 +++++++-
>  super0.c   |    6 ++++++
>  super1.c   |   30 +++++++++++++++++++++++++++++-
>  8 files changed, 116 insertions(+), 3 deletions(-)
> 
> diff --git a/Create.c b/Create.c
> index 292f92a9ae63..6f84e5b0de99 100644
> --- a/Create.c
> +++ b/Create.c
> @@ -51,6 +51,9 @@ static int default_layout(struct supertype *st, int level, int verbose)
>  		default: /* no layout */
>  			layout = 0;
>  			break;
> +		case 0:
> +			layout = RAID0_ORIG_LAYOUT;
> +			break;
>  		case 10:
>  			layout = 0x102; /* near=2, far=1 */
>  			if (verbose > 0)
> @@ -950,6 +953,11 @@ int Create(struct supertype *st, char *mddev,
>  				if (rv) {
>  					pr_err("ADD_NEW_DISK for %s failed: %s\n",
>  					       dv->devname, strerror(errno));
> +					if (errno == EINVAL &&
> +					    info.array.level == 0) {
> +						pr_err("Possibly your kernel doesn't support RAID0 layouts.\n");
> +						pr_err("Either upgrade, or use --layout=dangerous\n");
> +					}
>  					goto abort_locked;
>  				}
>  				break;
> @@ -1046,6 +1054,9 @@ int Create(struct supertype *st, char *mddev,
>  			if (ioctl(mdfd, RUN_ARRAY, &param)) {
>  				pr_err("RUN_ARRAY failed: %s\n",
>  				       strerror(errno));
> +				if (errno == 524 /* ENOTSUP */ &&
> +				    info.array.level == 0)
> +					cont_err("Please use --layout=original or --layout=alternate\n");
>  				if (info.array.chunk_size & (info.array.chunk_size-1)) {
>  					cont_err("Problem may be that chunk size is not a power of 2\n");
>  				}
> diff --git a/maps.c b/maps.c
> index 49b7f2c2d274..71e898eb9e05 100644
> --- a/maps.c
> +++ b/maps.c
> @@ -73,6 +73,18 @@ mapping_t r6layout[] = {
>  	{ NULL, UnSet }
>  };
>  
> +/* raid0 layout is only needed because of a bug in 3.13 which changed

s/3.13/3.14/

> + * the effective layout of raid0 arrays with varying device sizes.
> + */
> +mapping_t r0layout[] = {
> +	{ "original", RAID0_ORIG_LAYOUT},
> +	{ "alternate", RAID0_ALT_MULTIZONE_LAYOUT},
> +	{ "1", 1},
> +	{ "2", 2},

Nit - why not use the RAID0_ macros here as well, so it is clear which
that e.g. "1" is an alias for "original"?

> +	{ "dangerous", 0},
> +	{ NULL, UnSet},
> +};
> +
>  mapping_t pers[] = {
>  	{ "linear", LEVEL_LINEAR},
>  	{ "raid0", 0},
> diff --git a/md.4 b/md.4
> index e86707a2cbb3..6fe275541abd 100644
> --- a/md.4
> +++ b/md.4
> @@ -193,6 +193,20 @@ smallest device has been exhausted, the RAID0 driver starts
>  collecting chunks into smaller stripes that only span the drives which
>  still have remaining space.
>  
> +A bug was introduced in linux 3.14 which changed the layout of blocks in
> +a RAID0 beyond the region that is striped over all devices.  This bug
> +does not affect an array with all devices the same size, but can affect
> +other RAID0 arrays.
> +
> +Linux 5.4 (and some stable kernels to which the change was backported)
> +will not normally assemble such an array as it cannot know which layout
> +to use.  There is a module parameter "raid0.default_layout" which can be
> +set to "1" to force the kernel to use the pre-3.14 layout or to "2" to
> +force it to use the 3.14-and-later layout.  when creating a new RAID0
> +array,
> +.I mdadm
> +will record the chosen layout in the metadata in a way that allows newer
> +kernels to assemble the array without needing a module parameter.
>  
>  .SS RAID1
>  
> diff --git a/mdadm.8.in b/mdadm.8.in
> index 9aec9f4f7259..ea07c429e668 100644
> --- a/mdadm.8.in
> +++ b/mdadm.8.in
> @@ -593,6 +593,8 @@ to change the RAID level in some cases.  See LEVEL CHANGES below.
>  This option configures the fine details of data layout for RAID5, RAID6,
>  and RAID10 arrays, and controls the failure modes for

Should this list now include RAID0?

>  .IR faulty .
> +It can also be used for working around a kernel bug, but generaly

s/generaly/generally/

> +doesn't need to be used explicitly.
>  
>  The layout of the RAID5 parity block can be one of
>  .BR left\-asymmetric ,
> @@ -652,7 +654,7 @@ option to set subsequent failure modes.
>  "clear" or "none" will remove any pending or periodic failure modes,
>  and "flush" will clear any persistent faults.
>  
> -Finally, the layout options for RAID10 are one of 'n', 'o' or 'f' followed
> +The layout options for RAID10 are one of 'n', 'o' or 'f' followed
>  by a small number.  The default is 'n2'.  The supported options are:
>  
>  .I 'n'
> @@ -677,6 +679,32 @@ devices in the array.  It does not need to divide evenly into that
>  number (e.g. it is perfectly legal to have an 'n2' layout for an array
>  with an odd number of devices).
>  
> +A bug in Linux 3.14 means that RAID0 arrays

s/bug in/bug introduced in/

> +.B "with devices of differing sizes"
> +started using a different layout.  This could lead to
> +data corruption.  Since Linux 5.4 (and various stable releases that received
> +backports), the kernel will not accept such an array unless
> +a layout is explictly set.  It can be set to
> +.RB ' original '
> +or
> +.RB ' alternate '.
> +When creating a new array,
> +.I mdadm
> +will select
> +.RB ' original '
> +by default, so the layout does not normally need to be set.
> +An array created for either
> +.RB ' original '
> +or
> +.RB ' alternate '
> +with not be recognized by an (unpatched) kernel prior to 5.4.  To create

s/with not/will not/

I noticed this in my testing - definitely a nice feature :)

> +a RAID0 array with devices of differing sizes that can be used on an
> +older kernel, you can set the layout to
> +.RB ' dangerous '.
> +This will use whichever layout the running kernel supports, so the data
> +on the array may become corrupt when changing kernel from pre-3.14 to a
> +later kernel.
> +
>  When an array is converted between RAID5 and RAID6 an intermediate
>  RAID6 layout is used in which the second parity block (Q) is always on
>  the last device.  To convert a RAID5 to RAID6 and leave it in this new
> diff --git a/mdadm.c b/mdadm.c
> index 1fb8086050ee..e438f9c864da 100644
> --- a/mdadm.c
> +++ b/mdadm.c
> @@ -550,6 +550,14 @@ int main(int argc, char *argv[])
>  				pr_err("raid level must be given before layout.\n");
>  				exit(2);
>  
> +			case 0:
> +				s.layout = map_name(r0layout, optarg);
> +				if (s.layout == UnSet) {
> +					pr_err("layout %s not understood for raid0.\n",
> +						optarg);
> +					exit(2);
> +				}
> +				break;
>  			case 5:
>  				s.layout = map_name(r5layout, optarg);
>  				if (s.layout == UnSet) {
> diff --git a/mdadm.h b/mdadm.h
> index c88ceab01875..242fd864d657 100644
> --- a/mdadm.h
> +++ b/mdadm.h
> @@ -763,7 +763,8 @@ extern int restore_stripes(int *dest, unsigned long long *offsets,
>  
>  extern char *map_num(mapping_t *map, int num);
>  extern int map_name(mapping_t *map, char *name);
> -extern mapping_t r5layout[], r6layout[], pers[], modes[], faultylayout[];
> +extern mapping_t r0layout[], r5layout[], r6layout[],
> +	pers[], modes[], faultylayout[];
>  extern mapping_t consistency_policies[], sysfs_array_states[];
>  
>  extern char *map_dev_preferred(int major, int minor, int create,
> @@ -1757,6 +1758,11 @@ char *xstrdup(const char *str);
>  #define makedev(M,m) (((M)<<8) | (m))
>  #endif
>  
> +enum r0layout {
> +	RAID0_ORIG_LAYOUT = 1,
> +	RAID0_ALT_MULTIZONE_LAYOUT = 2,
> +};
> +
>  /* for raid4/5/6 */
>  #define ALGORITHM_LEFT_ASYMMETRIC	0
>  #define ALGORITHM_RIGHT_ASYMMETRIC	1
> diff --git a/super0.c b/super0.c
> index 42989b9f66eb..9adb33480783 100644
> --- a/super0.c
> +++ b/super0.c
> @@ -1291,6 +1291,12 @@ static int validate_geometry0(struct supertype *st, int level,
>  	if (*chunk == UnSet)
>  		*chunk = DEFAULT_CHUNK;
>  
> +	if (level == 0 && layout != UnSet) {
> +		if (verbose)
> +			pr_err("0.90 metadata does not support layouts for RAID0\n");
> +		return 0;
> +	}
> +
>  	if (!subdev)
>  		return 1;
>  
> diff --git a/super1.c b/super1.c
> index b85dc20ca605..312303fecbe1 100644
> --- a/super1.c
> +++ b/super1.c
> @@ -43,7 +43,7 @@ struct mdp_superblock_1 {
>  
>  	__u64	ctime;		/* lo 40 bits are seconds, top 24 are microseconds or 0*/
>  	__u32	level;		/* -4 (multipath), -1 (linear), 0,1,4,5 */
> -	__u32	layout;		/* only for raid5 currently */
> +	__u32	layout;		/* use for raid5, raid6, raid10, and raid0 */

s/use/used/

>  	__u64	size;		/* used size of component devices, in 512byte sectors */
>  
>  	__u32	chunksize;	/* in 512byte sectors */
> @@ -144,6 +144,7 @@ struct misc_dev_info {
>  #define	MD_FEATURE_JOURNAL		512 /* support write journal */
>  #define	MD_FEATURE_PPL			1024 /* support PPL */
>  #define	MD_FEATURE_MUTLIPLE_PPLS	2048 /* support for multiple PPLs */
> +#define	MD_FEATURE_RAID0_LAYOUT		4096 /* layout is meaninful in RAID0 */

s/meaninful/meaningful/

Those minor fixes aside, the code worked well for me. I was able to
create a new multi-zone array w/ and w/o an explicit layout, and was
able to change the layout of an existing array on assemble. I verified
I could view the layout w/ -E, and that it persisted across reboots.

Tested-by: dann frazier <dann.frazier@canonical.com>

  -dann


>  #define	MD_FEATURE_ALL			(MD_FEATURE_BITMAP_OFFSET	\
>  					|MD_FEATURE_RECOVERY_OFFSET	\
>  					|MD_FEATURE_RESHAPE_ACTIVE	\
> @@ -155,6 +156,7 @@ struct misc_dev_info {
>  					|MD_FEATURE_JOURNAL		\
>  					|MD_FEATURE_PPL			\
>  					|MD_FEATURE_MULTIPLE_PPLS	\
> +					|MD_FEATURE_RAID0_LAYOUT	\
>  					)
>  
>  static int role_from_sb(struct mdp_superblock_1 *sb)
> @@ -498,6 +500,11 @@ static void examine_super1(struct supertype *st, char *homehost)
>  	printf("         Events : %llu\n",
>  	       (unsigned long long)__le64_to_cpu(sb->events));
>  	printf("\n");
> +	if (__le32_to_cpu(sb->level) == 0 &&
> +	    (sb->feature_map & __cpu_to_le32(MD_FEATURE_RAID0_LAYOUT))) {
> +		c = map_num(r0layout, __le32_to_cpu(sb->layout));
> +		printf("         Layout : %s\n", c?c:"-unknown-");
> +	}
>  	if (__le32_to_cpu(sb->level) == 5) {
>  		c = map_num(r5layout, __le32_to_cpu(sb->layout));
>  		printf("         Layout : %s\n", c?c:"-unknown-");
> @@ -1646,6 +1653,7 @@ struct devinfo {
>  	int fd;
>  	char *devname;
>  	long long data_offset;
> +	unsigned long long dev_size;
>  	mdu_disk_info_t disk;
>  	struct devinfo *next;
>  };
> @@ -1687,6 +1695,7 @@ static int add_to_super1(struct supertype *st, mdu_disk_info_t *dk,
>  	di->devname = devname;
>  	di->disk = *dk;
>  	di->data_offset = data_offset;
> +	get_dev_size(fd, NULL, &di->dev_size);
>  	di->next = NULL;
>  	*dip = di;
>  
> @@ -1888,10 +1897,25 @@ static int write_init_super1(struct supertype *st)
>  	unsigned long long sb_offset;
>  	unsigned long long data_offset;
>  	long bm_offset;
> +	int raid0_need_layout = 0;
>  
>  	for (di = st->info; di; di = di->next) {
>  		if (di->disk.state & (1 << MD_DISK_JOURNAL))
>  			sb->feature_map |= __cpu_to_le32(MD_FEATURE_JOURNAL);
> +		if (sb->level == 0 && sb->layout != 0) {
> +			struct devinfo *di2 = st->info;
> +			unsigned long long s1, s2;
> +			s1 = di->dev_size;
> +			if (di->data_offset != INVALID_SECTORS)
> +				s1 -= di->data_offset;
> +			s1 /= __le32_to_cpu(sb->chunksize);
> +			s2 = di2->dev_size;
> +			if (di2->data_offset != INVALID_SECTORS)
> +				s2 -= di2->data_offset;
> +			s2 /= __le32_to_cpu(sb->chunksize);
> +			if (s1 != s2)
> +				raid0_need_layout = 1;
> +		}
>  	}
>  
>  	for (di = st->info; di; di = di->next) {
> @@ -2039,6 +2063,10 @@ static int write_init_super1(struct supertype *st)
>  			sb->bblog_offset = 0;
>  		}
>  
> +		/* RAID0 needs a layout if devices aren't all the same size */
> +		if (raid0_need_layout)
> +			sb->feature_map |= __cpu_to_le32(MD_FEATURE_RAID0_LAYOUT);
> +
>  		sb->sb_csum = calc_sb_1_csum(sb);
>  		rv = store_super1(st, di->fd);
>  
> 
> 
