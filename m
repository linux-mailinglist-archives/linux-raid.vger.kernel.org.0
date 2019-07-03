Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADD055DE81
	for <lists+linux-raid@lfdr.de>; Wed,  3 Jul 2019 09:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfGCHN6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 3 Jul 2019 03:13:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:57731 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfGCHN6 (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 3 Jul 2019 03:13:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 00:13:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="166439236"
Received: from unknown (HELO linux-spw6.localnet) ([10.102.102.170])
  by orsmga003.jf.intel.com with ESMTP; 03 Jul 2019 00:13:56 -0700
From:   Mariusz Dabrowski <mariusz.dabrowski@intel.com>
To:     John Stoffel <john@stoffel.org>
Cc:     jes.sorensen@gmail.com, linux-raid@vger.kernel.org,
        Krzysztof Smolinski <krzysztof.smolinski@intel.com>
Subject: Re: [PATCH] mdadm: load default sysfs attributes after assemblation
Date:   Wed, 03 Jul 2019 09:11:51 +0200
Message-ID: <2854351.AXMWJ9dCLp@linux-spw6>
In-Reply-To: <23834.26751.380798.383341@quad.stoffel.home>
References: <20190626075006.4815-1-mariusz.dabrowski@intel.com> <23834.26751.380798.383341@quad.stoffel.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Monday, July 1, 2019 10:09:35 PM CEST John Stoffel wrote:
> >>>>> "Mariusz" == Mariusz Dabrowski <mariusz.dabrowski@intel.com> writes:
> Mariusz> Added new type of line to mdadm.conf which allows to specify
> Mariusz> values of sysfs attributes for MD devices that should be
> Mariusz> loaded after assemblation.  Each line is interpreted as list
> Mariusz> of structures containing sysname of MD device (md126 etc.)
> Mariusz> and list of sysfs attributes and their values.
> 
> So what does this buy us?  Looking at your example, you hard code
> devices to a raid name, but also include a UUID setting.  Don't you
> think that's a bad idea?
The UUID and name are two ways to identify the device. In my examples, I have 
placed the UUID for the first device and the name for the second device.

> 
> 
> 
> Mariusz> +.TP
> Mariusz> +.B SYSFS
> Mariusz> +The SYSFS line lists custom values of MD device's sysfs attributes
> which will be Mariusz> +stored in sysfs after assemblation. Multiple lines
> are allowed and each line has
> 
> This should be "after assembly." Or maybe "after the array is
> assembled." instead.
> 
> Mariusz> +to contain uuid or name of the device to which it relates.
> 
> ... "contain the uuid" ...
> 
> Mariusz> +.RS 4
> Mariusz> +.TP
> Mariusz> +.B uuid=
> Mariusz> +hexadecimal identifier of MD device. This must match the uuid
> stored in the Mariusz> +superblock.
> Mariusz> +.TP
> Mariusz> +.B name=
> Mariusz> +name of the MD device as was given to
> Mariusz> +.I mdadm
> Mariusz> +when the array was created. It will be ignored if
> Mariusz> +.B uuid
> Mariusz> +is not empty.
> Mariusz> +.TP
> Mariusz> +.RS 7
> Mariusz> +
> Mariusz>  .SH EXAMPLE
> Mariusz>  DEVICE /dev/sd[bcdjkl]1
> Mariusz>  .br
> Mariusz> @@ -657,6 +677,11 @@ CREATE group=system mode=0640 auto=part\-8
> Mariusz>  HOMEHOST <system>
> Mariusz>  .br
> Mariusz>  AUTO +1.x homehost \-all
> Mariusz> +.br
> Mariusz> +SYSFS name=/dev/md/raid5 group_thread_cnt=4 sync_speed_max=1000000
> Mariusz> +.br
> Mariusz> +SYSFS uuid=bead5eb6:31c17a27:da120ba2:7dfda40d group_thread_cnt=4
> Mariusz> +sync_speed_max=1000000
> 
> So according to the docs above, since you have a SYSFS uuid=... entry,
> won't the name be ignored?
The name will be ignored if it is given next to uuid in the same entry, for 
example:
SYSFS uuid=bead5eb6:31c17a27:da120ba2:7dfda40d name=/dev/md/raid 
group_thread_cnt=4

> 
> Also, it's not clear if the case of these SYSFS atttribures matters or
> not.  I'd *hope* they don't, because I can see people putting in
> 
>  "SYSFS UUID=... "
> 
> Just like the regular ARRAY /dev/md3 UUID=... stuff in mdadm.conf
> already.
Case of UUID= and NAME= doesn't matter, but sysfs attribute name like 
"group_thread_count" have to be given in the same form as it is present in /
sys/block/mdX/md/.

> 
> Cheers,
> John
Regards,
Mariusz




