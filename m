Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C501B14201A
	for <lists+linux-raid@lfdr.de>; Sun, 19 Jan 2020 22:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgASVKp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 19 Jan 2020 16:10:45 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:55901 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgASVKp (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sun, 19 Jan 2020 16:10:45 -0500
Received: from [81.135.72.163] (helo=[192.168.1.162])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <antlists@youngman.org.uk>)
        id 1itHqE-0005SC-9L; Sun, 19 Jan 2020 21:10:43 +0000
Subject: Re: Two raid5 arrays are inactive and have changed UUIDs
To:     William Morgan <therealbrewer@gmail.com>
Cc:     linux-raid@vger.kernel.org
References: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
 <959ca414-0c97-2e8d-7715-a7cb75790fcd@youngman.org.uk>
 <CALc6PW7276uYYWpL7j2xsFJRy3ayZeeSJ9kNCGHvB6Ndb6m1-Q@mail.gmail.com>
 <5E17D999.5010309@youngman.org.uk>
 <CALc6PW5DrTkVR7rLngDcJ5i8kTpqfT1-K+ki-WjnXAYP5TXXZg@mail.gmail.com>
 <CALc6PW7hwT9VDNyA8wfMzjMoUFmrFV5z=Ve+qvR-P7CPstegvw@mail.gmail.com>
 <5E1DDCFC.1080105@youngman.org.uk>
 <CALc6PW5Y-SvUZ5HOWZLk2YcggepUwK0N===G=42uMR88pDfAVA@mail.gmail.com>
 <5E1FA3E6.2070303@youngman.org.uk>
 <CALc6PW4-yMdprmube0bKku0FJVKghYt4tjhep26sy3F9Q5cB4g@mail.gmail.com>
 <5E2494B3.9010006@youngman.org.uk>
 <CALc6PW6r8jn7nJcq-ceTboRkP5TYj0863bo856SS3TAus0mTSA@mail.gmail.com>
From:   Wol's lists <antlists@youngman.org.uk>
Message-ID: <917bd12e-3b76-2f27-8340-686dd71b1408@youngman.org.uk>
Date:   Sun, 19 Jan 2020 21:10:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CALc6PW6r8jn7nJcq-ceTboRkP5TYj0863bo856SS3TAus0mTSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 19/01/2020 20:12, William Morgan wrote:
> Still not sure why/dev/disk/by-id/  and/dev/disk/by-uuid/  would have
> differing UUIDs, but maybe that's normal.

Given that one is an ID, and the other is a UUID, I would have thought 
it normal that they're different (not that I know the difference between 
them! :-)

It would be nice if we had some decent docu on what all these assorted 
id's and uuid's and all that were, but I haven't managed to find any. 
Probably somewhere in the info pages for grub - given that I really 
don't like hypertext the fact that grub docu is very much hypertext is 
rather off-putting ...

Cheers,
Wol
