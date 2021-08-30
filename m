Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE753FB6A3
	for <lists+linux-raid@lfdr.de>; Mon, 30 Aug 2021 15:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhH3NCQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Aug 2021 09:02:16 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:56419 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229446AbhH3NCP (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 30 Aug 2021 09:02:15 -0400
Received: from [192.168.0.4] (ip5f5aed94.dynamic.kabel-deutschland.de [95.90.237.148])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 37D6E61E64761;
        Mon, 30 Aug 2021 15:01:20 +0200 (CEST)
Subject: Incorrect time (was: [PATCH] Grow: Close cfd file descriptor)
To:     Mateusz Kusiak <mateusz.kusiak@intel.com>
Cc:     jes@trained-monkey.org, linux-raid@vger.kernel.org
References: <20210830144939.29240-1-mateusz.kusiak@intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <95c075ec-dbf3-aab1-5e69-7adc401bd2c7@molgen.mpg.de>
Date:   Mon, 30 Aug 2021 15:01:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210830144939.29240-1-mateusz.kusiak@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Mateusz,


Am 30.08.21 um 16:49 schrieb Mateusz Kusiak:

[…]

Your systems date is incorrect. (I see that often from Intel 
contributors on intel-wired-lan@lists.osuosl.org. Can you please get to 
the bottom of this?


Kind regards,

Paul
